package wvutech.mailer;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Scanner;

/**
 * Create fake DB entries for the mailer to send.
 *
 * @author Ben Culkin
 */
public class MailerGen {
	private static final String PMSG_INS_STMT = "insert into pendingmsgs (recipient, mstype, body) values (?, ?::msgtype, ?)";

	public static void main(String[] args) {
		try {
			InputStream is = MailerGen.class.getResourceAsStream("/messages/PMSGS.mvars");
			try (Scanner scn = new Scanner(is)) {

				Class.forName("org.postgresql.Driver");
				try (Connection c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/labassist",
						"labassist", "labassist")) {
					PreparedStatement pmsgStmt = c.prepareStatement(PMSG_INS_STMT);

					while (scn.hasNextLine()) {
						String ln = scn.nextLine();

						pmsgStmt.setString(1, "80065284");
						pmsgStmt.setString(2, "PENDING_QUESTION");
						pmsgStmt.setString(3, ln);

						pmsgStmt.addBatch();
					}

					pmsgStmt.executeBatch();

					pmsgStmt.close();
				}
			}
		} catch (Exception ex) {
			System.out.printf("Error accessing the database (reason %s)\n", ex.getMessage());
			System.out.println();
			ex.printStackTrace();
		}
	}

	/**
	 * Data holder for fake message objects.
	 */
	public static class FakeMsg {
		public String recipient;
		public String mstype;
		public String body;
	}
}
