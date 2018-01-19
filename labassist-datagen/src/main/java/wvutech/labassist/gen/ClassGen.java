package wvutech.labassist.gen;

import bjc.rgens.newparser.RGrammars;

import wvutech.labassist.beans.Class;
import wvutech.labassist.beans.Department;

import wvutech.labassist.beans.Department.DepartmentID;

public class ClassGen {
	public Class generateClass(int cid, DepartmentID dept) {
		return new Class(cid, dept, RGrammars.generateExport("[college-course]"));
	}
}
