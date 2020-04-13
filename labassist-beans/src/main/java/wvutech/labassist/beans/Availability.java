package wvutech.labassist.beans;

import java.sql.Timestamp;

import static wvutech.labassist.beans.User.UserID;

/**
 * Indicates the timeframe a student is available during.
 * 
 * @author Ben Culkin
 *
 */
public class Availability {
	/**
	 * The student we're tracking the availability of.
	 */
	public final UserID student;

	/**
	 * The time the student starts being available.
	 */
	public final Timestamp start;
	/**
	 * The time the student stops being available.
	 */
	public final Timestamp end;

	/**
	 * Create an availability window for a student.
	 * 
	 * @param studnt
	 *               The student who is available.
	 * @param stat
	 *               The time the student becomes available.
	 * @param ed
	 *               The time the student stops being available.
	 */
	public Availability(UserID studnt, Timestamp stat, Timestamp ed) {
		student = studnt;

		start = stat;
		end = ed;
	}
}
