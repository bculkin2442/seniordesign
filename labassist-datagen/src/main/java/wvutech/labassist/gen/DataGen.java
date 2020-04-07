package wvutech.labassist.gen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

import wvutech.labassist.beans.*;

/**
 * Main class for generating data.
 *
 * @author Ben Culkin
 */
public class DataGen {
	private static int SCALE = 5;

	private static final String CONN_STRING = "jdbc:postgresql://localhost:5432/labassist";

	@SuppressWarnings("unused")
	private static List<TermCode> generateTermCode(int noCodes, Connection c) throws Exception {
		PreparedStatement stmt = c.prepareStatement("insert into  terms (code) values (?::termcode)");

		List<TermCode> list = new ArrayList<>(noCodes);

		for(int i = 0; i < noCodes; i++) {
			TermCode code = TermCodeGen.generateTermCode();

			list.add(code);

			stmt.setString(1, code.code);

			stmt.addBatch();
		}

		int[] res = stmt.executeBatch();

		c.commit();

		stmt.close();

		return list;
	}
	
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

		// TODO: handle possible errors and stuff
		@SuppressWarnings("unused")
		int[] res = stmt.executeBatch();

		c.commit();

		stmt.close();

		return list;
	}

	@SuppressWarnings("unused")
	private static List<Section> generateSections(int noSections, Connection c,
			List<wvutech.labassist.beans.Class> classes, List<TermCode> codes) {
		for(wvutech.labassist.beans.Class clasz : classes) {
			for(TermCode term : codes) {
				//generateSection(0, cid, user, term);
			}
		}

		return null;
	}

	private static List<wvutech.labassist.beans.Class> generateClasses(int noClasses, Connection c,
		List<Department> depts) throws Exception {
		PreparedStatement stmt = c.prepareStatement("insert into classes (dept, name) values (?, ?)");

		for(Department dept : depts) {
			for(int i = 0; i < noClasses; i++) {
				wvutech.labassist.beans.Class clasz = ClassGen.generateClass(0, dept.deptid);

				stmt.setString(1, clasz.department.deptid);
				stmt.setString(2, clasz.name);

				stmt.addBatch();
			}
		}

		// TODO: handle possible errors and stuff
		@SuppressWarnings("unused")
		int[] res = stmt.executeBatch();

		c.commit();

		stmt.close();

		List<wvutech.labassist.beans.Class> list = new ArrayList<>(noClasses);

		try (Statement stat = c.createStatement()) {
			ResultSet rs = stat.executeQuery("select cid, dept, name from classes");
			
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

				List<TermCode> codes = null;// = generateTermCodes(SCALE, c);

				List<Department> depts = generateDepartments(SCALE, c);

				List<wvutech.labassist.beans.Class> classes = generateClasses(SCALE, c, depts);

				// TODO: need this for future stuffs
				@SuppressWarnings("unused")
				List<Section> sections = generateSections(SCALE, c, classes, codes);
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
