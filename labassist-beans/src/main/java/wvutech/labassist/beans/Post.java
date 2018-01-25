package wvutech.labassist.beans;

import static wvutech.labassist.beans.User.UserID;

public class Post {
	public final int pid;
	public final int question;

	public final UserID author;
	public final String body;

	public final boolean isQuestion;

	public Post(int id, int queston, UserID auth, String bod, boolean qustion) {
		pid      = id;
		question = queston;

		author = auth;
		body   = bod;

		isQuestion = qustion;
	}
}
