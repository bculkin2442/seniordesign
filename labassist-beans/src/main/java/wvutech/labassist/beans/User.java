package wvutech.labassist.beans;

/**
 * Represents a user; whether it be a student, tutor or faculty member.
 *
 * @author Ben Culkin
 */
public class User {
	public final Role role;

	public final String idno;

	public final String username;
	public final String realname;
	public final String email;

	public User(Role role, String idno, String username, String realname, String email) {
		this.role = role;

		this.idno = idno;

		this.username = username;
		this.realname = realname;
		this.email    = email;
	}

	public static final class Builder {
		private Role role;

		private String idno;

		private String username;
		private String realname;
		private String email;

		public void role(Role role) {
			this.role = role;
		}

		public void idno(String idno) {
			this.idno = idno;
		}

		public void username(String username) {
			this.username = username;
		}

		public void realname(String realname) {
			this.realname = realname;
		}

		public void email(String email) {
			this.email = email;
		}

		public User build() {
			return new User(role, idno, username, realname, email);
		}
	}
}
