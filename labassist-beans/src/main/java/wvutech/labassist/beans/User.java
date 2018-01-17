package wvutech.labassist.beans;

/**
 * Represents a user; whether it be a student, tutor or faculty member.
 *
 * @author Ben Culkin
 */
public class User {
	public static class UserID {
		public final String uid;

		public UserID(String id) {
			uid = id;
		}
	}

	public UserID idno;

	public final String deptid;

	public final String username;
	public final String realname;
	public final String email;

	public final Role role;

	public User(UserID id, String dept, String user, String real, String mail, Role rol) {
		idno = id;

		deptid = dept;

		username = user;
		realname = real;
		email    = mail;

		role = rol;
	}
}
