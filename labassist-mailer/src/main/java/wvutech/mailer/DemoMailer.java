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
 * Proof of concept for sending mail
 *
 * @author Ben Culkin
 */
public class DemoMailer {
	public static void main(String[] args) {
		/* Open mail session. */
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.wvu.edu");

		Session sess = Session.getInstance(props, null);

		try {
			MimeMessage mmsg = new MimeMessage(sess);

			mmsg.setFrom("labassist@mail.wvu.edu");
			mmsg.setRecipients(Message.RecipientType.TO, "agcantrell@mix.wvu.edu");
			mmsg.setSubject("LabAssist Test Message");
			mmsg.setSentDate(new Date());
			mmsg.setText("If you are seeing this message, LabAssist's mailing notifications work");

			Transport.send(mmsg, "labassist@mail.wvu.edu", "");
		} catch (MessagingException mex) {
			System.out.printf("Message send failed (reason %s)\n", mex.getMessage());
			System.out.println();
			mex.printStackTrace();
		}
	}
}
