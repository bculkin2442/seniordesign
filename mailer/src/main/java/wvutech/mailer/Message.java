package wvutech.mailer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Represents a message that will be sent.
 *
 * @author Ben Culkin
 */
public class Message {
	/** The type of this message. */
	public final MessageType type;
	/* Who the message is addressed to. */
	private List<String> recipients;
	/* Message body variables. */
	private Map<String, String> vars;

	/**
	 * Create a new message of a given type.
	 *
	 * @param type
	 * 	The type of the message being created.
	 */
	public Message(MessageType type) {
		this.type = type;

		recipients = new ArrayList<>();
		vars       = new HashMap<>();
	}

	/**
	 * Add a series of recipients to the message.
	 *
	 * @param recipients
	 * 	All of the new recipients for this message.
	 */
	public void addRecipients(String... recipients) {
		for(String recipient : recipients) {
			this.recipients.add(recipient);
		}
	}

	/**
	 * Get the recipients of the message.
	 *
	 * @return
	 * 	A list of all of the recipients of the message.
	 */
	public List<String> getRecipients() {
		return recipients;
	}

	/**
	 * Add a message body variable.
	 *
	 * @param varName
	 * 	The name of the variable.
	 *
	 * @param varBody
	 * 	The contents of the variable.
	 */
	public void addVar(String varName, String varBody) {
		vars.put(varName, varBody);
	}

	/**
	 * Get all of the message body variables.
	 *
	 * @return
	 * 	All of the message body variables.
	 */
	public Map<String, String> getVars() {
		return vars;
	}

	/**
	 * Merge all of the body variables into a message template.
	 *
	 * Body variables in the template are indicated by {'s.
	 *
	 * For example, the string 'Hello {name}' contains a reference to the
	 * body variable name. If the name variable was set to 'bob', merging
	 * the body would create the string 'Hello bob'.
	 *
	 * @param body
	 * 	The body of the message.
	 *
	 * @return
	 * 	The message with body variables substituted.
	 */
	public String merge(String body) {
		String newBody = body;

		/* @NOTE
		 * 	There is probably a more efficent way to do this, but
		 * 	I'm not sure efficency is a real problem.
		 */
		for(Map.Entry<String, String> ent : vars.entrySet()) {
			newBody.replaceAll(String.format("{%s}", ent.getKey()), ent.getValue());
		}
		
		return newBody;
	}
}
