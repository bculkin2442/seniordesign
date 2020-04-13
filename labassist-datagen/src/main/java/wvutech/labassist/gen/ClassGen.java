package wvutech.labassist.gen;

import bjc.rgens.parser.RGrammars;

import wvutech.labassist.beans.Class;
import wvutech.labassist.beans.Department.DepartmentID;

/**
 * Utility class for generating class instances.
 * @author Ben Culkin
 *
 */
public class ClassGen {
	/**
	 * Generate a sample class
	 * @param cid The ID for the sample class.
	 * @param dept The department for the sample class.
	 * @return The sample class instance.
	 */
	public static Class generateClass(int cid, DepartmentID dept) {
		return new Class(cid, dept, RGrammars.generateExport("[college-course]"));
	}
}
