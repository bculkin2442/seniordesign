package wvutech.labassist.beans;

import static wvutech.labassist.beans.User.UserID;

public class Question {
	public final int quid;

	public final int subject;

	public final String title;
	
	public final UserID asker;

	public final QuestionStatus status;

	public Question(int qid, int sub, String titl, UserID ask, QuestionStatus stat) {
		quid = qid;

		subject = sub;

		title = titl;
		asker = ask;

		status = stat;
	}
}
