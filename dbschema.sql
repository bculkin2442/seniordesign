-- @TODO 10/10/17 Ben Culkin :Archival
-- 	An open question is what the policy for how to archive data that we
-- 	don't need very often but still need to keep around should be.

-- All of the possible roles for users, put in order of increasing privileges.
create type role as enum (
	student,
	tutor,
	staff,
	admin,
	sysadmin
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

-- Pending message notifications that haven't been dispatched yet.
create table pendingmsgs (
	-- @TODO 10/10/17 Ben Culkin :MsgTable
	-- 	Fill out this table once we know what needs to go here.
	-- 	Open questions are:
	-- 	- Does storing old messages serve any purposes?
	-- 	- Should we store the entire body of the message, or just some
	-- 		sort of list of data that we use to fill out a form
	-- 		email before we send it. (This could be JSON, XML or
	-- 		something else.)
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
	foreign key(term)    references terms(tid),
	foreign key(teacher) references users(idno)
);

-- List of who attends which sections
create table section_attends (
	student char(8),
	section int,

	-- True if someone is a tutor, instead of a student
	tutors boolean,

	-- @NOTE
	-- 	A student can't tutor a class he is currently in.
	primary key(student, section),

	foreign key(student) references users(idno),
	foreign key(section) references sections(secid)
);

-- @TODO 10/10/17 Ben Culkin :DBSchema
-- 	Pick up with the DB schema. The remaining things are:
-- 	- Questions (Question/Answer System)
--		Contains user questions/answers. How should the various states
--		of a question be handled? (Things like if a question/response is
--		pending and notifications need to be distributed)
-- 	- Usage     (Clock in/out)
--		Usage schedules of the labs.
-- 	- Schedule  (Clock in/out)
--		Schedules of the tutor. Both availabilty and actual schedule
--		need to be handled.
