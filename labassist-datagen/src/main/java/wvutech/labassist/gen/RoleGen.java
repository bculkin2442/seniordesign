package wvutech.labassist.gen;

import bjc.rgens.parser.RGrammars;

import wvutech.labassist.beans.Role;

public class RoleGen {
	public static Role generateRole() {
		return Role.valueOf(RGrammars.generateExport("[user-role]"));
	}
}
