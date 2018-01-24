package wvutech.mailer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;

public class SessionCloser {
	private static final String OPENSESSION_QUERY =
		  "select usr.email as email, usr.realname as student, clas.name as cname,"
		+ " usag.student as studid, usag.secid as section, usag.markin as intime"
		+ " from usage usag join users usr on usag.student = usr.idno"
		+ " join sections sect on usag.secid = sect.secid"
		+ " join classes clas on sect.cid = clas.cid"
		+ " where usag.markout is null";

	private static final String CLOSESESSION_QUERY =
		"update usage set markout = current_timestamp where student = ? and secid = ? and markin = ?";

	public static List<wvutech.mailer.Message> getMessages() {
		List<wvutech.mailer.Message> messages = new LinkedList<>();

		try {
			Class.forName("org.postgresql.Driver");

			try(Connection c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/labassist", "labassist", "labassist")) {
				c.setAutoCommit(false);

				Statement stmt = c.createStatement();

				PreparedStatement prep = c.prepareStatement(CLOSESESSION_QUERY);

				try(ResultSet rs = stmt.executeQuery(OPENSESSION_QUERY)) {
					while(rs.next()) {
						String email = rs.getString("email").trim();
						String name  = rs.getString("student").trim();
						String clas  = rs.getString("cname").trim();

						prep.setString(1, rs.getString("studid"));
						prep.setInt(2, rs.getInt("section"));
						prep.setTimestamp(3, rs.getTimestamp("intime"));

						prep.addBatch();

						wvutech.mailer.Message msg = new wvutech.mailer.Message(MessageType.AUTOCLOCK);

						msg.addRecipients(email);

						msg.addVar("recipient", name);
						msg.addVar("class", clas);

						messages.add(msg);
					}
				}

				prep.executeBatch();

				c.commit();

				prep.close();

				stmt.close();
			} catch (SQLException sqlex) {
				System.out.println("ERROR: Something went wrong accessing the database");

				sqlex.printStackTrace();
			}
		} catch (Exception ex) {
				System.out.println("ERROR: Something went wrong accessing the database");

				ex.printStackTrace();
		}

		return messages;
	}

	public static void main(String[] args) {
		/* Open mail session. */
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.wvu.edu");

		Session sess = Session.getInstance(props, null);

		int nmsg = 0;
		for(wvutech.mailer.Message msg : getMessages()) {
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
