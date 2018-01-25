package wvutech.mailer;

import java.io.InputStream;

import java.util.Map;
import java.util.Scanner;

/**
 * Represents the various types of messages that can be sent.
 *
 * @author Ben Culkin
 */
public enum MessageType {
	/**
	 * A clock-out has been automatically generated.
	 */
	AUTOCLOCK,
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
		case AUTOCLOCK:
			return "[LabAssist] Automatic Clockout";
		case PENDING_QUESTION:
			return "[LabAssist] You have Pending Questions";
		case SCHEDULE_CHANGED:
			return "[LabAssist] Lab Schedule has Changed";
		default:
			return "[LabAssist] Notification";
		}
	}

	public String getBody() {
		InputStream strem = this.getClass().getResourceAsStream(String.format("/messages/%s.mbody", this.toString()));

		StringBuilder sb = new StringBuilder();

		Scanner scn = new Scanner(strem);

		while(scn.hasNextLine()) {
			sb.append(scn.nextLine());
		}

		return sb.toString();
	}

	public void mergeVars(Map<String, String> src, Map<String, String> dest) {
		switch(this) {
		case PENDING_QUESTION:
			{
				String recipient  = src.get("recipient");
				String nquestions = src.get("nquestions");
				String questions  = src.get("questions");

				if(recipient  == null) recipient  = "";
				if(nquestions == null) nquestions = "0";
				if(questions  == null) questions  = "";

				dest.merge("recipient", recipient, (srcString, destString) -> {
					if(srcString == null) {
						if(destString == null) {
							return "";
						}

						return destString;
					} else if (destString == null) {
						return srcString;
					}

					return String.format("%s ; %s", srcString, destString);
				});

				dest.merge("nquestions", nquestions, (srcString, destString) -> {
					if(srcString == null) {
						if(destString == null) {
							return "0";
						}

						return destString;
					} else if(destString == null) {
						return srcString;
					}

					/*
					 * @NOTE
					 * this'll fail for improperly formatted
					 * nquestion bvars.
					 */
					return String.format("%d", Integer.parseInt(srcString) + Integer.parseInt(destString));
				});

				dest.merge("questions", questions, (srcString, destString) -> {
					if(srcString == null) {
						if(destString == null) {
							return "";
						}

						return destString;
					} else if (destString == null) {
						return srcString;
					}

					return String.format("%s\n%s", srcString, destString);
				});
			}
			return;
		case SCHEDULE_CHANGED:
			return;
		default:
			return;
		}
	}
}
