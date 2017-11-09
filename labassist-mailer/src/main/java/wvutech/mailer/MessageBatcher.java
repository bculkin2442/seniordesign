package wvutech.mailer;

import java.util.LinkedList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

/**
 * Batch messages together.
 *
 * This does the following:
 * 1. Aggregate messages of the same type for the same recipients into digest
 *    messages.
 * 2. Aggregate identical messages for different recipients.
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
		Map<MessageType, Map<List<String>, Message>> batched = new HashMap<>();

		for(Message msg : msgs) {
			Map<List<String>, Message> typeMap = batched.computeIfAbsent(msg.type, (typ) -> {
				System.out.println("TRACE: getting new type map");

				return new HashMap<>();
			});

			Message merged = typeMap.computeIfAbsent(msg.getRecipients(), (recips) -> {
				System.out.println("TRACE: getting new message");

				Message nmg = new Message(msg.type);

				nmg.addRecipients(recips.toArray(new String[recips.size()]));

				return nmg;
			});

			msg.type.mergeVars(msg.getVars(), merged.getVars());
		}
		
		msgs.clear();

		for(Map<List<String>, Message> typeMap : batched.values()) {
			for(Message mg : typeMap.values()) {
				msgs.add(mg);
			}
		}
	}
}
