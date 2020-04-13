package wvutech.labassist.beans;

import static wvutech.labassist.beans.Department.DepartmentID;

/**
 * A class offered by a department.
 * 
 * @author Ben Culkin
 *
 */
public class Class {
	/**
	 * The unique ID for this class.
	 */
	public final int cid;

	/**
	 * The department that offers this class.
	 */
	public final DepartmentID department;

	/**
	 * The name of the class.
	 */
	public final String name;

	/**
	 * Create a new class instance.
	 * 
	 * @param id
	 *             The ID of the class.
	 * @param dept
	 *             The department offering the class.
	 * @param nam
	 *             The name of the class.
	 */
	public Class(int id, DepartmentID dept, String nam) {
		cid = id;

		department = dept;

		if (nam.length() > 4) {
			name = nam.substring(0, 250);
		} else {
			name = nam;
		}
	}
}
