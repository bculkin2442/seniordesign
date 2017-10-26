package wvutech.mailer;

import java.io.InputStream;

import java.util.Scanner;

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
		InputStream strem = this.getClass().getResourceAsStream(String.format("messages/%s.mbody", this.toString()));

		StringBuilder sb = new StringBuilder();

		Scanner scn = new Scanner(strem);

		while(scn.hasNextLine()) {
			sb.append(scn.nextLine());
		}

		return sb.toString();
	}
}
