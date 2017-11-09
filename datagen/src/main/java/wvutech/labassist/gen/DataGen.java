package wvutech.labassist.gen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import bjc.rgens.newparser.GrammarException;
import bjc.rgens.newparser.RGrammars;

/**
 * Main class for generating data.
 *
 * @author Ben Culkin
 */
public class DataGen {
	private static final String CONN_STRING = "jdbc:postgresql://localhost:5432/labassist";


	public static void main(String[] args) {
		try {
			Class.forName("org.postgresql.Driver");

			try(Connection c = DriverManager.getConnection(CONN_STRING, "labassist", "labassist")) {
				Statement stmt = c.createStatement();

				stmt.close();
			} catch (Exception ex) {
				System.out.println("ERROR: Something went wrong (doing stuff with database)");

				ex.printStackTrace();
			}
		} catch (Exception ex) {
			System.out.println("ERROR: Something went wrong (couldn't load driver)");

			ex.printStackTrace();

		}
	}
}
