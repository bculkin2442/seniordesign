package wvutech.mailer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.List;
import java.util.LinkedList;

/**
 * Grab messages from the database.
 *
 * @author Ben Culkin
 */
public class MessageGrabber {
	private static final String MSGGET_QUERY =
		"select p.msgid, u.email, p.mstype, p.body from pendingmsgs p inner join users u on u.idno = p.recipient";

	private static final String MSGDELETE_QUERY_FMT =
		"delete from pendingmsgs p where p.msgid <= %s";

	public static List<Message> getMessages() {
		List<Message> msgs = new LinkedList<>();

		try {
			Class.forName("org.postgresql.Driver");
			try(Connection c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/labassist", "labassist", "labassist")) {
				Statement stmt = c.createStatement();
				
				int maxid = 0;
				int nmsgs = 0;

				try (ResultSet rs = stmt.executeQuery(MSGGET_QUERY)) {
					while(rs.next()) {
						maxid = Math.max(maxid, rs.getInt("msgid"));
						
						String recipient = rs.getString("email");
						String body      = rs.getString("body");

						MessageType type = MessageType.valueOf(rs.getString("mstype"));

						Message msg = new Message(type);

						msg.addRecipients(recipient);
						for(String bvar : body.split(";")) {
							int colIdx = bvar.indexOf(':');

							if(colIdx == -1) {
								System.out.printf("ERROR: improperly formatted body variable %s (missing :)\n", bvar);

								continue;
							}

							String varName = bvar.substring(0, colIdx).trim();
							String varBody = bvar.substring(colIdx).trim();

							msg.addVar(varName, varBody);
						}

						msgs.add(msg);
						nmsgs += 1;
					}
				}

				int ndeleted = stmt.executeUpdate(String.format(MSGDELETE_QUERY_FMT, maxid));

				if(ndeleted != nmsgs) {
					System.out.printf("WARNING: Count of deleted messages is not equal to number of recieved messages (%d deleted vs %d retrieved, delta of %d)\n", ndeleted, nmsgs, ndeleted - nmsgs);
				}

				stmt.close();
			}
		} catch (Exception ex) {
			System.out.printf("Error accessing the database (reason %s)\n", ex.getMessage());
			System.out.println();
			ex.printStackTrace();
		}

		return msgs;
	}
}
