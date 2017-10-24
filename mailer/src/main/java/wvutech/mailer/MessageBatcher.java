package wvutech.mailer;

import java.util.List;

/**
 * Batch messages together.
 *
 * This does things like 
 * - Aggregate identical messages for different recipients
 * - Aggregate messages of the same type for the same recipients
 *
 * @author Ben Culkin
 */
public class MessageBatcher {
	/**
	 * Batch a list of messages together.
	 *
	 * @param msgs
	 * 	The list of messages to batch together.
	 */
	public static void batch(List<Message> msgs) {

	}
}
