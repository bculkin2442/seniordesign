package wvutech.labassist.gen;

import bjc.rgens.newparser.RGrammars;

import wvutech.labassist.beans.Section;
import wvutech.labassist.beans.User;

import static wvutech.labassist.beans.User.UserID;

public class SectGen {
	public static Section generateSection(int sid, int cid, UserID user, TermCode term) {
		String sectCode = RGrammars.generateExport("[section-code]");

		return new Section(sid, sectCode, cid, term, user);
	}
}
