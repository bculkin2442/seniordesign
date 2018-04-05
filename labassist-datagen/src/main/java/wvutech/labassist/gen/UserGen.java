package wvutech.labassist.gen;

import bjc.rgens.parser.RGrammars;

import wvutech.labassist.beans.Role;
import wvutech.labassist.beans.User;

import static wvutech.labassist.beans.User.UserID;

public class UserGen {
	public static User generateUser(Role rol, String deptid) {
		UserID id = new UserID(RGrammars.generateExport("[user-idno]"));

		String username = RGrammars.generateExport("[username]");
		String realname = RGrammars.generateExport("[full-name]");
		String email    = RGrammars.generateExport("[email]");

		return new User(id, deptid, username, realname, email, rol);
	}
}
