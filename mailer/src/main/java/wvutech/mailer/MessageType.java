package wvutech.mailer;

/**
 * Represents the various types of messages that can be sent.
 *
 * @author Ben Culkin
 */
public enum MessageType {
	/**
	 * There is a question awaiting a response.
	 *
	 * Could be either
	 * - A question awaiting an answer.
	 * - A question with an unread answer.
	 */
	PENDING_QUESTION,
	/**
	 * A change has been made to a tutors schedule.
	 */
	SCHEDULE_CHANGED;

	public String getSubject() {
		switch(this) {
		case PENDING_QUESTION:
			return "[LabAssist] You have Pending Questions";
		case SCHEDULE_CHANGED:
			return "[LabAssist] Lab Schedule has Changed";
		default:
			return "[LabAssist] Notification";
		}
	}

	public String getBody() {
		/*
		 * @TODO 10/24/17 Ben Culkin :MsgBody
		 * 	Create message bodies in external files and load them.
		 */
		return "NO MESSAGE BODY";
	}
}
