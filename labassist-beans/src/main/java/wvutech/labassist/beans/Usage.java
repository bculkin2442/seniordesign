package wvutech.labassist.beans;

import java.sql.Timestamp;

import static wvutech.labassist.beans.User.UserID;

public class Usage {
	public final UserID student;
	public final int    section;

	public final Timestamp mark;

	public final boolean checkin;

	public Usage(UserID studnt, int sect, Timestamp mrk, boolean check) {
		student = studnt;
		section = sect;

		mark = mrk;

		checkin = check;
	}
}
