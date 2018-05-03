-- @TODO 10/10/17 Ben Culkin :Archival
-- 	An open question is what the policy for how to archive data that we
-- 	don't need very often but still need to keep around should be.

-- @TODO 10/24/17 Ben Culkin :SampleData
-- 	Write something to generate sample data, probably using RGen

-- All of the possible roles for users, put in order of increasing privileges.
create type role as enum (
	'sysadmin',
	'student',
	'tutor',
	'staff',
	'admin',
	'developer'
);

-- This table tracks which role a user must be at least as privileged as to
-- access a web page.
create table pageaccess (
	role role NOT NULL,
	page text NOT NULL,

	primary key(role, page)
);

-- The maximum length of a department ID
create domain deptid as varchar(6);

-- The departments that are in the system
create table departments (
	-- The department ID
	deptid deptid,

	-- The department name
	deptname varchar(255) UNIQUE NOT NULL,

	primary key(deptid)
);

-- The length of a user ID is always 9 characters
create domain userid as char(9);

-- The table of all of the users in the system.
create table users (
	-- Key for IDing users
	idno userid,

	-- @NOTE
	-- 	This should only be null for students and tutors and other roles
	-- 	that aren't bound to a single department
	--
	-- @NOTE
	-- 	Convert this to a join table if we need to
	deptid deptid,

	-- The username of the user.
	username varchar(255) NOT NULL,
	-- The real name of the user.
	realname varchar(255) NOT NULL,
	-- The contact address for the user.
	email    varchar(255) NOT NULL,

	-- The users role
	role role             NOT NULL,

	primary key(idno),

	foreign key(deptid) references departments(deptid)
);

-- Stores user avatars for the forum system
create table user_avatars (
	-- ID of the user.
	idno userid,

	-- The image data, encoded in base64
	image text   NOT NULL,

	primary key(userid),

	foreign key(idno) references users(idno)
);

-- Represents the types of mailer notifications that are sent.
-- 	Change this if you are adding a notification type.
create type msgtype as enum (
	'PENDING_QUESTION',
	'SCHEDULE_CHANGED'
);

-- Pending message notifications that haven't been dispatched yet.
create table pendingmsgs (
	-- ID of the message.
	msgid serial,

	-- Who the message is addressed to
	recipient userid        NOT NULL,

	-- The type of message being sent
	mstype msgtype          NOT NULL,
	-- The body of the message. See the postNotification function for
	-- formatting details
	body   text             NOT NULL,

	primary key(msgid),

	foreign key(recipient) references users(idno)
);

-- List of all classes that have ever been offered.
create table classes (
	-- ID of the class
	cid serial,

	-- Department the class belongs to
	dept deptid       NOT NULL,

	-- The name of the class
	name varchar(255) NOT NULL,

	primary key(cid),
	
	foreign key(dept) references departments(deptid)
);

-- ID for each term
--
-- Consists of the 4-digit year, then the 2-digit month the term started in
create domain termcode as char(6);

-- List of all terms that have existed.
create table terms (
	-- Code for the term
	code termcode  NOT NULL,
	
	-- Whether or not this term is the active one.
	activeterm boolean NOT NULL,

	primary key(code)
);

-- Ensure that at most one term can be marked as active
create unique_index on terms(activeterm) where activeterm = true;

-- List of all sections of classes.
create table sections (
	-- ID of the section
	secid serial,

	-- Code for the section
	code    char(3)  NOT NULL,

	-- ID of the class
	cid     int      NOT NULL,
	-- Code for the term
	term    termcode NOT NULL,
	-- ID for the teacher
	teacher userid   NOT NULL,

	primary key(secid),

	foreign key(cid)     references classes(cid),
	foreign key(term)    references terms(code),
	foreign key(teacher) references users(idno)
);

-- List of clock in/outs for lab usage.
create table usage (
	-- Student who being clocked
	student userid,
	-- Section that is being clocked
	secid   int,

	-- Time IN/OUT stamps
	-- 	Set markin first, then set markout
	markin    timestamp NOT NULL,
	markout   timestamp,

	primary key(student, secid, markin),

	foreign key(student) references users(idno),
	foreign key(secid)   references sections(secid),

	-- Ensure that clock in/outs are ordered properly
	check(markin < markout)
);

-- 	For easy querying, the question/answer system has been split into two
-- 	tables.
-- 	- Questions
-- 		One entry in this table exists for every question.
-- 	- Posts
-- 		One entry in this table exists for every question/answer to that
-- 		question.

-- The possible statuses for a question
create type question_status as enum (
	'awaiting_response',
	'answered'
);

-- List of all asked questions
create table questions (
	-- ID of the question
	quid serial,

	-- Term for the question
	term    termcode       NOT NULL,
	-- Class being asked about
	subject int            NOT NULL,

	-- Title of the question
	title varchar(255)     NOT NULL,
	-- Person asking the question
	asker userid           NOT NULL,

	-- The status of the question
	status question_status NOT NULL,

	-- Date this question was posted
	added timestamp     NOT NULL;

	primary key(quid),

	foreign key(term)    references terms(code),
	foreign key(subject) references sections(secid),
	foreign key(asker)   references users(idno)
);

-- List of all of the posts for questions
create table posts (
	-- ID of the post
	postid   serial,
	-- ID of the question
	question int,

	-- Person who wrote the post
	author userid       NOT NULL,
	-- Body of the post
	body   text         NOT NULL,

	-- True if this post is a question, false if this quest is an answer
	is_question boolean NOT NULL,

	-- When the post was posted
	added timestamp     NOT NULL;

	primary key(postid, question),

	foreign key(question) references questions(quid),
	foreign key(author)   references users(idno)
);

-- List of when tutors are available to be scheduled
create table availability (
	-- The student who is available
	student userid,
	-- The department they are available for
	dept    deptid,

	-- Times user is available to/from
	-- 	Various places in the code assume these are 30 minutes apart
	starttime timestamp NOT NULL,
	endtime   timestamp NOT NULL,

	-- Term student is available for
	term termcode       NOT NULL,

	primary key(student, dept),

	foreign key(student) references users(idno),
	foreign key(dept) references departments(deptid),

	-- Ensure times make sense
	check(starttime < endtime)
);

-- List of when tutors are scheduled to be active
create table schedules (
	-- Student who is scheduled
	student userid,
	-- Department they are scheduled for
	dept    deptid,

	-- Times user is scheduled to/from
	-- 	Various places in the code assume these are 30 minutes apart
	starttime timestamp NOT NULL,
	endtime   timestamp NOT NULL,

	-- Term student is scheduled for
	term termcode       NOT NULL,
	
	primary key(student, dept),

	foreign key(student) references users(idno),
	foreign key(dept) references departments(deptid),

	check(starttime < endtime);
);

-- Department lab constraints
create table deptlabs (
	--  Department being constrained
	dept deptid,
	
	-- Max Start/end times for labs
	labstart timestamp NOT NULL,
	labend   timestamp NOT NULL,

	primary key(dept),

	foreign key(dept) references departments(deptid)
);

-------------------------------------------------
-- VIEW DEFINITIONS
-------------------------------------------------
-- All of the sections for the current term
CREATE VIEW term_sections AS (
	SELECT * FROM sections WHERE sections.term =
		(SELECT terms.code FROM terms WHERE terms.activeterm = true)
);

-- All of the users that are staff
CREATE VIEW staff_users AS (
	SELECT * FROM users WHERE users.role >= 'staff'::role
);

-- Provide class/professor counts for departments
CREATE VIEW dept_stats AS (
	WITH class_counts AS (
		SELECT COUNT(classes.cid) AS classcount, classes.dept
			FROM classes
			GROUP BY classes.dept
	), prof_counts AS (
		SELECT staff_users.deptid, COUNT(staff_users.idno) AS profcount
			FROM staff_users 
			GROUP BY staff_users.deptid
	)
	SELECT departments.deptid, departments.deptname, 
		COALESCE(class_counts.classcount, 0) AS class_count,
		COALESCE(prof_counts.profcount, 0)   AS prof_count
		FROM departments
		LEFT OUTER JOIN class_counts ON (departments.deptid = class_counts.dept)
		LEFT OUTER JOIN prof_counts  ON (departments.deptid = prof_counts.deptid)
		ORDER BY departments.deptname
);

-- Provide the listing of 'boards' in the question/answer system
CREATE VIEW forum_overview AS (
	-- This query will select all of the departments that have at least one question
	-- attached to them
	WITH filt_questions AS (
		SELECT * from questions WHERE questions.term = (SELECT code FROM terms WHERE activeterm = true)
	)
	SELECT departments.deptid, departments.deptname,
		COUNT(filt_questions.quid) AS question_count,
		COUNT(filt_questions.quid) FILTER 
			(WHERE filt_questions.status = 'awaiting_response') AS unanswered_count
		FROM departments
		LEFT JOIN classes        ON departments.deptid = classes.dept
		LEFT JOIN filt_questions ON classes.cid        = filt_questions.subject
		GROUP BY departments.deptid
		ORDER BY departments.deptname
);

-- Provide data on the total usage of the labs by students
CREATE VIEW student_total_usage AS (
	-- Get the total number of hours each student is using per section
	SELECT users.idno, users.realname, users.role,
		SUM(usage.markout - usage.markin) as total_hours
		FROM usage
		JOIN term_sections ON usage.secid   = term_sections.secid
		JOIN users         ON usage.student = users.idno
		WHERE usage.markout IS NOT NULL
		GROUP BY usage.student, users.realname, users.role, users.idno
		ORDER BY users.role, users.realname;
);
