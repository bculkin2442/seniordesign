package wvutech.mailer;

import java.util.Date;
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

		try {
			MimeMessage msg = new MimeMessage(sess);

			msg.setFrom("labassist@mail.wvu.edu");
			msg.setRecipients(Message.RecipientType.TO, "agcantrell@mix.wvu.edu");
			msg.setSubject("LabAssist Mailer Testing");
			msg.setSentDate(new Date());
			msg.setText("If you are seeing this, LabAssist's mailing system works.\n");

			Transport.send(msg, "labassist@mail.wvu.edu", "");
		} catch (MessagingException mex) {
			System.out.printf("Message send failed (reason %s)\n", mex.getMessage());
			System.out.println();
			mex.printStackTrace();
		}
	}
}
