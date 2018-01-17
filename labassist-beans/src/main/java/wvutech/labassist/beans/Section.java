package wvutech.labassist.beans;

import static wvutech.labassist.beans.User.UserID;

public class Section {
	public final int secid;

	public final String code;

	public final int      clasz;
	public final TermCode term;
	public final UserID   teacher;

	public Section(int id, String cod, int clas, TermCode trm, UserID teach) {
		secid = id;

		code = cod;

		clasz   = clas;
		term    = trm;
		teacher = teach;
	}
}
