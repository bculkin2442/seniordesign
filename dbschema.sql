-- @TODO 10/10/17 Ben Culkin :Archival
-- 	An open question is what the policy for how to archive data that we
-- 	don't need very often but still need to keep around should be.

-- All of the possible roles for users, put in order of increasing privileges.
create type role as enum (
	'student',
	'tutor',
	'staff',
	'admin',
	'sysadmin'
);

-- The users of the system.
create table users (
	-- Every user has an 8 char ID number from WVU.
	--
	-- @NOTE
	-- 	If DB space becomes an issues, swap to using an integer key as
	-- 	the primary.
	idno char(8),

	realname varchar(255) NOT NULL,
	email    varchar(255) NOT NULL,

	role role             NOT NULL,

	primary key(idno)
);

create type msgtype as enum (
	-- @TODO 10/10/17 Ben Culkin :MsgTypes
	-- 	Fill this in with the types of messages we need.
);

-- Pending message notifications that haven't been dispatched yet.
create table pendingmsgs (
	msgid serial,

	-- SQL standard array syntax.
	--
	-- @NOTE
	-- 	Should this stay as an array, or should it be moved to a join
	-- 	table or something, because the patch for array foreign keys
	-- 	never seems to have been accepted.
	recipient char(8) array NOT NULL,

	mstype msgtype          NOT NULL,
	body   text             NOT NULL,

	primary key(msgid)

	-- Uncomment this if we store the list of recipients in some other way.
	--foreign key(recipient) references users(idno)
);

-- List of all classes that have ever been offered.
create table classes (
	cid serial,

	name varchar(255) NOT NULL,

	primary key(cid)
);

-- List of all terms that have existed.
create table terms (
	code char(6) NOT NULL,

	primary key(code)
);

-- List of all sections of classes.
create table sections (
	secid serial,

	code    char(2)   NOT NULL,

	class   int       NOT NULL,
	term    char(6)   NOT NULL,
	teacher char(8)   NOT NULL,

	primary key(secid),

	foreign key(class)   references classes(cid),
	foreign key(term)    references terms(code),
	foreign key(teacher) references users(idno)
);

-- List of who attends which sections
create table section_attends (
	student char(8),
	section int,

	-- True if someone is a tutor, instead of a student
	tutors boolean   NOT NULL,

	-- @NOTE
	-- 	A student can't tutor a class he is currently in.
	primary key(student, section),

	foreign key(student) references users(idno),
	foreign key(section) references sections(secid)
);

-- List of clock in/outs for lab usage.
create table usage (
	student char(8),
	section int,
	mark    timestamp,

	-- True if this is a check in, false if it is a check out.
	checkin boolean    NOT NULL,

	-- @NOTE
	-- 	Should section be a part of this?
	primary key(student, section, mark),

	foreign key(student) references users(idno),
	foreign key(section) references sections(secid)
);

-- @NOTE
-- 	For easy querying, the question/answer system has been split into two
-- 	tables.
-- 	- Questions
-- 		One entry in this table exists for every question.
-- 	- Posts
-- 		One entry in this table exists for every question/answer to that
-- 		question.

create type question_status as enum (
	'awaiting_response',
	'answered'
);

-- List of all asked questions
create table questions (
	quid serial,

	title varchar(255)     NOT NULL,
	asker char(8)          NOT NULL,

	status question_status NOT NULL,

	primary key(quid),

	foreign key(asker) references users(idno)
);

-- List of all of the posts for questions
create table posts (
	postid   serial,
	question int,

	author char(8)      NOT NULL,
	body   text         NOT NULL,

	-- True if this post is a question, false if this quest is an answer
	is_question boolean NOT NULL,

	primary key(postid, question),

	foreign key(question) references questions(quid),
	foreign key(author)   references users(idno)
);

-- List of which tutors are available, and for how long
create table availability (
	student   char(8),

	starttime timestamp NOT NULL,
	endtime   timestamp NOT NULL,

	primary key(student, starttime),

	foreign key(student) references users(idno)
);

-- List of when tutors are scheduled to be active
create table schedules (
	student char(8),
	section int,

	starttime timestamp NOT NULL,
	endtime   timestamp NOT NULL,

	primary key(student, section),

	foreign key(student) references users(idno),
	foreign key(section) references sections(secid)
);
-- @TODO 10/16/17 Ben Culkin :DBSchema
--	Add constraints where appropriate to the schema.
--
--	I'm consider using triggers for ensuring consistency on some of the
--	tables, but not sure if that is how things should go.
