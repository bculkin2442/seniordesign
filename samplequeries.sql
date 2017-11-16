-- Provide a list of all of the students in all of the sections for all of the classes
create view section_students as (
	select u.idno as userid, u.realname as studentname, c.dept as department, c.name as classname, s.code as seccode
	from sections s
		join classes c where (s.class = c.cid)
		join section_attends sa where (sa.section = s.secid AND sa.tutors = false)
		join users u where (sa.student = u.idno AND u.role IN ('student'::role, 'tutor'::role))
);

-- Provide a list of all of the tutors for all of the sections for all of the classes
create view section_tutors as (
	select u.idno as userid, u.realname as tutorname, c.dept as department, c.name as classname, s.code as seccode
	from sections s
		join classes c where (s.class = c.cid)
		join section_attends sa where (sa.section = s.secid AND sa.tutors = true)
		join users u where (sa.student = u.idno AND u.role IN ('student'::role, 'tutor'::role))
);

-- Provide a list of all of the teachers of all of the sections of all of the classes
create view section_teachers as (
	select u.idno as userid, u.realname as teachername, c.dept as department, c.name as classname, s.code as seccode
	from sections s
		join classes c where (s.class = c.cid)
		join users u where (s.teacher = u.idno AND u.role IN ('staff'::role, 'admin'::role))
);
