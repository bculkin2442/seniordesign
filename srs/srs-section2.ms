.Section "Overall Description"
.Para
This section will give an overview of the whole system. The system will be
explained with how it interacts along with other systems, and introduce
the basic functionality of the system. It will also detail who will use the
system, and what functionality will be available to which users. It will
conclude with a description of the constraints/assumptions the system is
operating under.
.Subhead "Product Perspective"
\# @TODO add system block diagram
.Para
The system consists of a web portal with two distinct modes. The first will be
used for tracking time in/out of people using or tutoring in a lab, while the
second will provide statistical information on this usage, as well as an quick
place for students to ask tutors questions when they are not in the lab.
.Para
The first mode, called Kiosk Mode for its intended usage of being available to
anyone for quick and easy usage, needs to interact with a card reader to gather
user IDs easily. This is important because not only is swiping your card easier
than entering a 10-digit number, not everyone has theirs memorized, and having
to look it up online would take a substantial amount of time.
.Para
The second mode, called User Mode for its being the general mode for everyone
who isn't using the clock in/out functionality, must be able to authorize users
in some way to prevent people from accessing functionality they shouldn't be
able to, or masquerading as other users without their permission. To do this,
the system will use the WVU user authentication system to ensure people are who
they say they are, thus absolving us of the responsibility of storing user names
and passwords and giving people the tools to manage them.
.Para
Since the intended primary function of the system is its statistical abilities,
and statistics of any sort require data, the system makes use of a database for
data storage. Kiosk mode only needs to be able to enter clock in/outs, while
User mode needs to be able to access varying parts of the database to record
things and provide statistical reports.
.Superhead "System Interfaces"
.Para
LabAssist does not have any pre-existing systems that it needs to interact with
to be able to do its job.
.Endsup
.Superhead "Interfaces"
.Para
Users will interact with LabAssist through a web interface with two possible
modes, Kiosk and User mode.
.Para
The main difference between Kiosk mode and User mode is that User mode has a
concept of a current user, someone who is actively using the site. With Kiosk
mode, once you have clocked in/out the system goes back to its initial state,
waiting for another person to use it. With User mode, the system does not do
this reset until the user explicitly log out.
.Endsup
.Superhead "Hardware Interfaces"
.Para
The system interacts with a hardware card reader, but does not need to make any
sort of special effort to interact with it since the card reader presents itself
as a keyboard input device, with a card swipe producing the equivalent of
manually keying the ID number and hitting enter on the keyboard.
.Endsup
.Superhead "Software Interfaces"
.Para
The system is not mandated to be able to connect to any particular sort of
software.
.Endsup
.Superhead "Communications Interfaces"
.Para
The system communicates to the WVU authentication system using the LDAP
protocol. Communications to and from the database are taken care of by the
operating system.
.Para
For sending email notifications to users, the system will use SMTP.
.Endsup
.Superhead "Memory Constraints"
.Para
The system does not have any hard memory constraints.
.Endsup
.Superhead "Operations"
To backup and restore the system, it will use the backup/restore capabilities of
the database.
.Endsup
.Superhead "Site Adaptation Requirements"
.Para
Before the web portal can function, the configuration must be changed to provide
connection information for a database initialized with the correct tables, as
well as a LDAP compatible server for user information.
.Para
The computers that will be used for kiosks also need a card reader attached to
them.
.Endsup
.Endsub
.Subhead "Product Functions"
.Para
The systems functionality is split into two modes: Kiosk and User. To control
access to functionality and data, users are also split into five distinct
classes: Student, Tutor, Staff, Administrator and System Administrator. All of
the user classes are able to use User Mode, but only Student and Tutor can use
Kiosk mode. See Fig. 1 for a visual explanation.
\# @TODO write a figure macro that auto-numbers them
.B1
.PS
boxwid = 1;
copy "usermodes.pic"
.PE
.B2
.ce 1
\fBFig. 1: \fPUsers and the Modes they Use.
.Superhead "Kiosk Mode"
.Para
Kiosk Mode is the mode concerned with data entry into the time-keeping system.
Students will use it to log when they are coming to the help lab, and what they
are coming for help with, and Tutors will use it to log when they are in the
lab.
.Para
The system also needs to be concerned with ensuring that this time-keeping data
is good, and that people aren't mismatching clock in/outs or simply forgetting
to clock out.
.Endsup
.Superhead "User Mode"
.Para
User Mode is the ``general use'' mode of the system. All of the classes of user
can use it, but their class determines what functionality of it they can use.
There are four main functions available in user mode:
.RS
.nr ufeatnum 0 1
.IP \n+[ufeatnum].
Scheduling
.IP \n+[ufeatnum].
Question/Answer
.IP \n+[ufeatnum].
Statistical Reports
.IP \n+[ufeatnum].
Administration
.RE
.Para
Scheduling is available to Students, Tutors and Staff. Students can use it to
view the schedule of Tutors, Tutors can notify Staff as to when they are
available to tutor, and Staff can use this information to arrange Tutors into
the schedule that the Students see. The system may also be able to do this
automatically.
.Para
Question/Answer is available to Students, Tutors and Staff. Students can ask
questions, and then the Tutors and Staff can answer these questions. Once a
question has been answered, a student can then ask follow-up questions, and
Tutors/Staff can ask for clarification.
.Para
Statistical Reports are available to Staff and Administrators. Staff and
Administrators can view statistical graphs detailing the usage of the lab in the
following qualities:
.RS
.nr statreportnum 0 1
.IP \n+[statreportnum].
Times Most Utilized
.IP \n+[statreportnum].
Days Most Utilized
.IP \n+[statreportnum].
Classes Most Utilized
.RE
Only Administrators can view reports for the following qualities:
.RS
.nr statreportnum 0
.IP \n+[statreportnum].
Professors Most Utilized
.RE
.Para
Administration is accessible to Staff, Administrators and System Administrators.
This is what allows Staff to promote Students to Tutors, System Administrators
to promote Staff to Administrators and allows classes to be created.
.Endsup
.Endsub
.Subhead "User Characteristics"
.Para
This system is intended to be usable by the general student and faculty of the
University. Thus, while we assume the general user is aware of how to use a
webpage, we assume that this is the limit of their technical ability.
.Para
Therefore, we need to make sure that we don't end up using confusing or
technical terminology, because not everybody is familiar with it.
.Endsub
.Subhead "Constraints"
There are no particular constraints foreseen for the system.
.Endsub
.Subhead "Assumptions/Dependencies"
The system assumes that we have access to the University authentication system
over LDAP, and thus we depend on having this continued access.
.Endsub
.Subhead "Apportioning of Requirements"
.Para
Depending on both time and implementation difficulty, the ability for the system
to automatically schedule tutors based off their declared times may be pushed
off to a further version.
.Para
We don't foresee any other features that will have issues with timing during
implementation.
.Endsub
.Endsec
