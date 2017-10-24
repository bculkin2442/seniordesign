package wvutech.mailer;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Grab messages from the database.
 *
 * @author Ben Culkin
 */
public class MessageGrabber {
	public static void getMessages() {
		try {
			Class.forName("org.postgresql.Driver");
			try(Connection c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/labassist", "labassist", "labassist")) {

			}
		} catch (Exception ex) {
			System.out.printf("Error accessing the database (reason %s)\n", ex.getMessage());
			System.out.println();
			ex.printStackTrace();
		}
	}
}
