package wvutech.labassist.gen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

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

	private static List<Department> generateDepartments(int noDepts, Connection c) throws Exception {
		PreparedStatement stmt = c.prepareStatement("insert into departments (deptid, deptname) values (?, ?)");

		List<Department> list = new ArrayList<>(noDepts);

		for(int i = 0; i < noDepts; i++) {
			Department dept = DeptGen.generateDepartment();

			list.add(dept);

			stmt.setString(1, dept.deptid.deptid);
			stmt.setString(2, dept.deptname);

			stmt.addBatch();
		}

		int[] res = stmt.executeBatch();

		c.commit();

		stmt.close();

		return list;
	}

	private static List<wvutech.labassist.beans.Class> generateClasses(int noClasses, Connection c, List<Department> depts) throws Exception {
		PreparedStatement stmt = c.prepareStatement("insert into departments (dept, name) values (?, ?)");

		for(Department dept : depts) {
			for(int i = 0; i < noClasses; i++) {
				wvutech.labassist.beans.Class clasz = ClassGen.generateClass(0, dept.deptid);

				stmt.setString(1, clasz.department.deptid);
				stmt.setString(2, clasz.name);

				stmt.addBatch();
			}
		}

		int[] res = stmt.executeBatch();

		c.commit();

		stmt.close();

		List<wvutech.labassist.beans.Class> list = new ArrayList<>(noClasses);

		try (Statement stat = c.createStatement()) {
			ResultSet rs = stat.executeQuery("select cid, dept, name frmo classes");
			
			while(rs.next()) {
				Department.DepartmentID did = new Department.DepartmentID(rs.getString("dept"));

				list.add(new wvutech.labassist.beans.Class(rs.getInt("cid"), did, rs.getString("name")));
			}

			rs.close();
		}

		return list;
	}

	public static void main(String[] args) {
		try {
			java.lang.Class.forName("org.postgresql.Driver");

			try(Connection c = DriverManager.getConnection(CONN_STRING, "labassist", "labassist")) {
				c.setAutoCommit(false);

				List<Department> depts = generateDepartments(5, c);

				List<wvutech.labassist.beans.Class> classes = generateClasses(5, c, depts);
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
