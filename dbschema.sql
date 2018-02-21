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

create table pageaccess (
	role role NOT NULL,
	page text NOT NULL,

	primary key(role, page)
);

create domain deptid as varchar(6);

-- The departments that are in the system
create table departments (
	deptid deptid,

	deptname varchar(255) UNIQUE NOT NULL,

	primary key(deptid)
);

-- Every user has an 9 char ID number from WVU.
--
-- @NOTE
-- 	If DB space becomes an issues, swap to using an integer key as
-- 	the primary.
create domain userid as char(9);

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

	username varchar(255) NOT NULL,
	realname varchar(255) NOT NULL,
	email    varchar(255) NOT NULL,

	role role             NOT NULL,

	primary key(idno),

	foreign key(deptid) references departments(deptid)
);

create table user_avatars (
	idno userid,

	image bytea   NOT NULL,

	primary key(userid),

	foreign key(idno) references users(idno)
);

create type msgtype as enum (
	-- @TODO 10/10/17 Ben Culkin :MsgTypes
	-- 	Fill this in with the types of messages we need.
	'PENDING_QUESTION',
	'SCHEDULE_CHANGED'
);

-- Pending message notifications that haven't been dispatched yet.
create table pendingmsgs (
	msgid serial,

	recipient userid        NOT NULL,

	mstype msgtype          NOT NULL,
	body   text             NOT NULL,

	primary key(msgid),

	foreign key(recipient) references users(idno)
);

-- List of all classes that have ever been offered.
create table classes (
	cid serial,

	dept deptid       NOT NULL,

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
	code termcode NOT NULL,

	primary key(code)
);

-- List of all sections of classes.
create table sections (
	secid serial,

	code    char(3)  NOT NULL,

	cid     int      NOT NULL,
	term    termcode NOT NULL,
	teacher userid   NOT NULL,

	primary key(secid),

	foreign key(cid)     references classes(cid),
	foreign key(term)    references terms(code),
	foreign key(teacher) references users(idno)
);

-- List of clock in/outs for lab usage.
create table usage (
	student userid,
	secid   int,

	markin    timestamp NOT NULL,
	markout   timestamp,

	primary key(student, secid, markin),

	foreign key(student) references users(idno),
	foreign key(secid)   references sections(secid)
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

	subject int            NOT NULL,

	title varchar(255)     NOT NULL,
	asker userid           NOT NULL,

	status question_status NOT NULL,

	primary key(quid),

	foreign key(subject) references sections(secid),
	foreign key(asker) references users(idno)
);

-- List of all of the posts for questions
create table posts (
	postid   serial,
	question int,

	author userid       NOT NULL,
	body   text         NOT NULL,

	-- True if this post is a question, false if this quest is an answer
	is_question boolean NOT NULL,

	primary key(postid, question),

	foreign key(question) references questions(quid),
	foreign key(author)   references users(idno)
);

-- List of which tutors are available, and for how long
create table availability (
	student   userid,

	starttime timestamp NOT NULL,
	endtime   timestamp NOT NULL,

	primary key(student, starttime),

	foreign key(student) references users(idno)
);

-- List of when tutors are scheduled to be active
create table schedules (
	student userid,
	secid int,

	starttime timestamp NOT NULL,
	endtime   timestamp NOT NULL,

	primary key(student, secid),

	foreign key(student) references users(idno),
	foreign key(secid) references sections(secid)
);

-- @TODO 10/16/17 Ben Culkin :DBSchema
--	Add constraints where appropriate to the schema.
--
--	I'm consider using triggers for ensuring consistency on some of the
--	tables, but not sure if that is how things should go.
