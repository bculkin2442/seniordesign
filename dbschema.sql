create type stampcheck as enum ('in', 'out');

create table supervisors (
	supid serial,

	name varchar(255)   NOT NULL,

	primary key(supid)
);

create table sections (
	secid serial,
	supid int          NOT NULL,

	name  varchar(255) NOT NULL,

	primary key(secid),
	foreign key(supid) references supervisors(supid)
);

create table tutors (
	tutid serial,

	name varchar(255) NOT NULL,
	
	primary key(tutid)
);

create table labusage (
	stuid char(9)     NOT NULL,

	marker timestamp  NOT NULL,
	inout  stampcheck NOT NULL,

	secid int         NOT NULL,
	tutid int         NOT NULL,

	primary key(stuid, marker),

	foreign key(secid) references sections(secid),
	foreign key(tutid) references tutors(tutid)
);

create type weekday as enum (
	'monday',
	'tuesday',
	'wednesday',
	'thursday',
	'friday',
	'saturday',
	'sunday'
);

create table labschedule (
	tutid int     NOT NULL,
	secid int     NOT NULL,

	day   weekday NOT NULL,
	start time    NOT NULL,
	len   time    NOT NULL,

	primary key(tutid, secid, day, start),
	foreign key(tutid) references tutors(tutid),
	foreign key(secid) references sections(secid)
);
