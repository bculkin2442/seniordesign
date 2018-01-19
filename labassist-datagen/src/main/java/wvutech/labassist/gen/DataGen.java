package wvutech.labassist.gen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bjc.rgens.newparser.GrammarException;
import bjc.rgens.newparser.RGrammars;

import wvutech.labassist.beans.*;

/**
 * Main class for generating data.
 *
 * @author Ben Culkin
 */
public class DataGen {
	private static final String CONN_STRING = "jdbc:postgresql://localhost:5432/labassist";

	public static void main(String[] args) {
		try {
			java.lang.Class.forName("org.postgresql.Driver");

			try(Connection c = DriverManager.getConnection(CONN_STRING, "labassist", "labassist")) {
				c.setAutoCommit(false);

				PreparedStatement stmt = c.prepareStatement("insert into departments (deptid, deptname) values (?, ?)");

				for(int i = 0; i < 5; i++) {
					Department dept = DeptGen.generateDepartment();

					stmt.setString(1, dept.deptid.deptid);
					stmt.setString(2, dept.deptname);

					stmt.addBatch();
				}

				int[] res = stmt.executeBatch();

				c.commit();

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
