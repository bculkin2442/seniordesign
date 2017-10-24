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
	SCHEDULE_CHANGED
}
