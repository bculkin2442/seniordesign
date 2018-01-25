package wvutech.labassist.gen;

import bjc.rgens.newparser.RGrammars;

import wvutech.labassist.beans.Department;

import static wvutech.labassist.beans.Department.DepartmentID;

public class DeptGen {
	public static Department generateDepartment() {
		DepartmentID id = new DepartmentID(RGrammars.generateExport("[dept-id]"));

		String name = RGrammars.generateExport("[university-subject]");

		return new Department(id, name);
	}
}
