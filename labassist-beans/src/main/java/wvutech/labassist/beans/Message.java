package wvutech.labassist.beans;

public class Message {
	public final int msgid;

	public final User.UserID recipient;

	public final MessageType type;
	public final String      body;

	public Message(int id, User.UserID recip, MessageType typ, String bod) {
		msgid = id;

		recipient = recip;

		type = typ;
		body = bod;
	}
}
