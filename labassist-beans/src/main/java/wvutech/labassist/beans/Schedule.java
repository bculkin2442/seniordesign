package wvutech.labassist.beans;

import java.sql.Timestamp;

import static wvutech.labassist.beans.User.UserID;

public class Schedule {
	public final UserID student;
	public final int    secid;

	public final Timestamp start;
	public final Timestamp end;

	public Schedule(UserID studnt, int sect, Timestamp stat, Timestamp ed) {
		student = studnt;
		secid   = sect;

		start = stat;
		end   = ed;
	}
}
