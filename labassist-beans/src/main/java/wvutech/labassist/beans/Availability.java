package wvutech.labassist.beans;

import java.sql.Timestamp;

import static wvutech.labassist.beans.User.UserID;

public class Availability {
	public final UserID student;

	public final Timestamp start;
	public final Timestamp end;

	public Availability(UserID studnt, Timestamp stat, Timestamp ed) {
		student = studnt;

		start = stat;
		end   = ed;
	}
}
