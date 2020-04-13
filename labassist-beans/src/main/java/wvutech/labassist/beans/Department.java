package wvutech.labassist.beans;

/**
 * A department for class containment.
 * @author Ben Culkin
 *
 */
public class Department {
	/**
	 * The ID for a department.
	 * @author Ben Culkin
	 *
	 */
	public static class DepartmentID {
		/**
		 * The ID for the department. Must be 4 chars or shorter.
		 */
		public final String deptid;

		/**
		 * Create a department ID.
		 * @param id The department ID. Truncated to 4 characters.
		 */
		public DepartmentID(String id) {
			if(id.length() > 4) {
				deptid = id.substring(0, 4);
			} else {
				deptid = id;
			}
		}
	}

	/**
	 * The ID of the department.
	 */
	public final DepartmentID deptid;

	/**
	 * The name of the department.
	 */
	public final String deptname;

	/**
	 * Create a new department.
	 * @param id The ID of the department.
	 * @param name The name of the department.
	 */
	public Department(DepartmentID id, String name) {
		deptid = id;

		deptname = name;
	}

	@Override
	public String toString() {
		return String.format("department[id=%s,name=%s]", deptid, deptname);
	}
}
