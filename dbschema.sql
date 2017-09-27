create type stampcheck as enum ('in', 'out');

create table supervisors (
	supid serial,

	name varchar(255)   NOT NULL,

	primary key(supid)
);

create table terms (
	-- Long enough for {Winter,Spring,Summer,Fall}YYY
	tercode varchar(10),

	primary key(tercode)
)

create table classes (
	clasid serial,

	term  varchar(10) NOT NULL,

	name varchar(255)  NOT NULL,

	primary key(clasid),
	foreign key(term) references terms(tercode)
);

create table sections (
	secid serial,

	supid  int          NOT NULL,
	clasid int          NOT NULL,

	name  varchar(255)  NOT NULL,

	primary key(secid),
	foreign key(supid)  references supervisors(supid),
	foreign key(clasid) references classes(clasid)
);

create table tutors (
	tutid serial,

	name    varchar(255) NOT NULL,
	contact varchar(255) NOT NULL,
	
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
