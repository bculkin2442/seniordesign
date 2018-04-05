package wvutech.labassist.gen;

import bjc.rgens.parser.RGrammars;

import wvutech.labassist.beans.Class;
import wvutech.labassist.beans.Department.DepartmentID;

public class ClassGen {
	public static Class generateClass(int cid, DepartmentID dept) {
		return new Class(cid, dept, RGrammars.generateExport("[college-course]"));
	}
}
