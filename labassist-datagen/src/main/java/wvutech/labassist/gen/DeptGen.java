package wvutech.labassist.gen;

import bjc.rgens.parser.RGrammars;

import wvutech.labassist.beans.Department;

import static wvutech.labassist.beans.Department.DepartmentID;

/**
 * Generator for departments.
 * @author Ben Culkin
 *
 */
public class DeptGen {
	/**
	 * Generate a department.
	 * @return A generated department.
	 */
	public static Department generateDepartment() {
		DepartmentID id = new DepartmentID(RGrammars.generateExport("[dept-id]"));

		String name = RGrammars.generateExport("[university-subject]");

		return new Department(id, name);
	}
}
