package wvutech.mailer;

import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;

/**
 * Main class for batch dispatching of mail messages.
 *
 * @author Ben Culkin
 */
public class Mailer {
	public static void main(String[] args) {
		/* Open mail session. */
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.wvu.edu");

		Session sess = Session.getInstance(props, null);

		/* Retrieve messages from the database. */
		List<wvutech.mailer.Message> msgs = MessageGrabber.getMessages();

		/* Batch messages together. */
		MessageBatcher.batch(msgs);

		int nmsg = 0;
		for(wvutech.mailer.Message msg : msgs) {
			try {
				nmsg += 1;
				MimeMessage mmsg = new MimeMessage(sess);

				mmsg.setFrom("labassist@mail.wvu.edu");

				for(String recip : msg.getRecipients()) {
					mmsg.setRecipients(Message.RecipientType.TO, recip);
				}

				mmsg.setSubject(msg.type.getSubject());
				mmsg.setSentDate(new Date());

				String body = msg.merge(msg.type.getBody());

				mmsg.setText(msg.merge(body));

				System.out.printf("Sending msg %d:\n%s" , nmsg, msg);
				//Transport.send(mmsg, "labassist@mail.wvu.edu", "");
			} catch (MessagingException mex) {
				System.out.printf("Message send failed (reason %s)\n", mex.getMessage());
				System.out.println();
				mex.printStackTrace();
			}
		}
	}
}
