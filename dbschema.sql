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
	code termcode  NOT NULL,
	
	activeterm boolean NOT NULL,

	primary key(code)
);

-- Ensure that at most one term can be marked as active
create unique_index on terms(activeterm) where activeterm = true;

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

	term    termcode       NOT NULL,
	subject int            NOT NULL,

	title varchar(255)     NOT NULL,
	asker userid           NOT NULL,

	status question_status NOT NULL,

	added timestamp     NOT NULL;

	primary key(quid),

	foreign key(term)    references terms(code),
	foreign key(subject) references sections(secid),
	foreign key(asker)   references users(idno)
);

-- List of all of the posts for questions
create table posts (
	postid   serial,
	question int,

	author userid       NOT NULL,
	body   text         NOT NULL,

	-- True if this post is a question, false if this quest is an answer
	is_question boolean NOT NULL,

	added timestamp     NOT NULL;

	primary key(postid, question),

	foreign key(question) references questions(quid),
	foreign key(author)   references users(idno)
);

-- List of when tutors are available to be scheduled
create table availability (
	student userid,
	dept    deptid,

	starttime timestamp NOT NULL,
	endtime   timestamp NOT NULL,

	term termcode       NOT NULL,

	primary key(student, dept),

	foreign key(student) references users(idno),
	foreign key(dept) references departments(deptid)
);

-- List of when tutors are scheduled to be active
create table schedules (
	student userid,
	dept    deptid,

	starttime timestamp NOT NULL,
	endtime   timestamp NOT NULL,

	term termcode       NOT NULL,
	
	primary key(student, dept),

	foreign key(student) references users(idno),
	foreign key(dept) references departments(deptid)
);

-- Department lab constraints
create table deptlabs (
	dept deptid,
	
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

-- @TODO 10/16/17 Ben Culkin :DBSchema
--	Add constraints where appropriate to the schema.
--
--	I'm consider using triggers for ensuring consistency on some of the
--	tables, but not sure if that is how things should go.
