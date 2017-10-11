.Section "Specific Features"
.Para
This section contains all of the functional and quality requirements of the
system. It gives a detailed description of the system and all of its features.
.Subhead "External Interface Requirements"
.Para
This section provides a detailed description of all inputs into/outputs from the
system. It also gives a description of the hardware, software and communication
interfaces and provides basic prototypes of the user interface.
.Superhead "User Interfaces"
.Para
.DS
.PSPIC "kiosklogin.ps" 
.ce 1
\fBFig. 2:\fPKiosk Mode Login
.DE
.DS
.PSPIC "userlogin.ps" 
.ce 1
\fBFig. 3:\fPUser Mode Login
.DE
.DS
.PSPIC "genericui.ps" 
.ce 1
\fBFig. 4:\fPUser Mode Homepage
.DE
.DS
.PSPIC "forum.ps" 
.ce 1
\fBFig. 5:\fPQuestion/Answer Forum Thread
.DE
.Para
Users have two methods of logging into the system as shown in Figures 2 and
Figure 3. Figure 2 shows the kiosk system login. This interface is designed for
use by students and tutors for arrivals and depatures only. It does not log the
user into the web portal.
.Para
Figure 3 demonstrates the User Mode login to access the portal. All users of
the system have the ability to login with this interface to access further
functionality such as Question/Answer system as well as statistical/administrative
duties such as reports and management. Both the Kiosk (Figure 2) and User Mode
(Figure 3) trigger a new user registration if this is the first time the user
has logged into the system.
.Para
Figure 4 shows the format of the portal once a user has successfully logged in.
The portal contains navigation links to all functions a user has permission to access. 
.Endsup
.Superhead "Hardware Interfaces"
.Para
Our only direct hardware interface is the key-card reader attached to the client
kiosks that students and tutors use to sign in/out. Other than that, we don't
have any specialized hardware usage, with the connection to the database being
managed by the operating system on the web server.
.Endsup
.Superhead "Software Interfaces"
.Para
The database and web server communicate with each to both read and write data to
and from the database.
.Endsup
.Superhead "Communications Interfaces"
.Para
The database and web server need to talk with each other, but the exact way
they do so is not important, and left up to the operating system.
.Para
The web server also communicates with the credential system of the University
over LDAP to allow access to the full functionality of the system.
.Endsub
.Endsub
.Subhead "Functional Requirements"
.Para
This section includes all of the fundamental requirements for various actions
within the system.
.nr frnum 1
.Superhead "User Roles"
.Reqr "Each User has an Assigned Role"
Each user shall be assigned a role from the following list (in order of
increasing power):
.RS
.nr rolenum 0 1
.IP \n+[rolenum].
Student
.IP \n+[rolenum].
Tutor
.IP \n+[rolenum].
Staff
.IP \n+[rolenum].
Administrator
.IP \n+[rolenum].
System Administrator
.RE
.Reqr "Users have a default Role"
Each new user of the system shall be assigned the role of Student by default.
.Endsup
.Superhead "Login/Logout (All Users)"
.Reqr "Access the Website"
The user shall be able to access the website using a modern web browser.
.Reqr "Enter Kiosk Mode"
The user shall be able to enter their Student ID no. to login to Kiosk mode.
.Reqr "Real Names, Emails and Usernames Associated with ID Numbers"
When the user logs in to Kiosk Mode for the first time, they shall be prompted
for their university username and password.
.Para
Using this information, their real name and email address will be read from the
university's systems and stored in the database with their ID number and
username.
.Reqr "Clock in/out via Kiosk Mode"
The user shall be able to perform the following steps once logged into Kiosk
Mode.
.nr kiosklist 0 1
.RS
.IP \n+[kiosklist].
If you are a tutor, select whether you are in the lab as a tutor or as a
student.
.IP \n+[kiosklist].
If you have no unmatched arrivals: Select the class you are here for.
.RE
.Para
The system shall then do one of the following:
.RS
.IP \[bu]
If you have an arrival not matched with a departure, mark a departure for that
arrival.
.IP \[bu]
Otherwise, register an arrival for the selected class as the type of user you
selected from step 1 above. 
.RE
.Para
Afterwards, the user shall be returned to the starting page for Kiosk Mode.
.Reqr "Missed departures are adjusted."
At midnight, all arrivals without a corresponding departure shall have
one generated for 11:59 PM that day, and a notification stating such shall be
emailed to the user.
.Reqr "Enter User Mode"
The user shall be able to use their university-issued username and password to
enter User Mode.
.Reqr "Student ID Number Associated with Usernames"
When the user first logs in to User Mode, they shall be prompted for their
Student ID number if they have not previously logged into Kiosk Mode and
associated their username with their ID.
.Para
Once they have done so, their real name and email address will be pulled from
the University's systems and stored in the database alongside their username and
ID number.
.Reqr "Exit User Mode"
The user shall be able to log out of User Mode, requiring them to log back in
before they can access the system again.
.Endsup
.Superhead "Scheduling (Students/Tutors/Staff)"
.Reqr "User must be in User Mode"
The user shall be currently logged in to User Mode to use scheduling features.
.Reqr "Students may view the schedules of Tutors"
Students shall be able to view a schedule that shows the times when Tutors are
available in the lab, and which tutor or tutors are in the lab at that time.
.Reqr "Tutors may register when they are free to tutor"
Tutors shall be able to use a form to submit times when they are available to do
tutoring.
.Reqr "Staff may schedule Tutors into the lab"
Members of the Staff shall be able to view a list of when Tutors are free to
tutor, and fill out a schedule as to when and which tutors are available in the
lab.
.Reqr "Tutors will be notified when their schedule changes"
Tutors shall be notified via email whenever they are added to a schedule, their
time in the schedule is changed, or they are removed from the schedule.
.Endsup
.Superhead "Questions/Answers (Students/Tutors/Staff)"
.Reqr "User must be in User Mode"
The user shall be currently logged in to User Mode to use question/answer features.
.Reqr "Students can Submit Questions"
Students shall be able to select a class they are in and submit questions to be
answered by the Tutors/Staff assigned to that class.
.Reqr "Students are Notified when Questions are Answered"
Students shall be notified via email whenever a question they have posted is
answered by a tutor or staff member.
.Reqr "Students may View Questions"
Students shall be able to view a list of questions they have submitted, and the
answers to those questions if they are available
\# @TODO should students be able to ask 'follow-up' questions.
\# ANSWER: forum-based discussion.
.Reqr "Tutors/Staff are Notified of Questions Needing Answers"
Tutors and Staff shall be notified via email when a question is posted that they
are allowed to answer.
.Reqr "Tutors/Staff can Answer Questions"
Tutors and Staff shall be able to answer questions asked by Students in classes
they are assigned to.
.Reqr "Tutors/Staff can View Questions"
Tutors and Staff shall be able to view all of the questions asked by Students in
classes they are assigned to, regardless of whether or not the question has been
answered.
.Endsup
.Superhead "Statistical Reports and Data (Staff and Administrators)"
.Reqr "User must be in User Mode"
The user shall be currently logged in to User Mode to use statistical features.
.Reqr "Staff/Administrators can View Statistical Charts on Lab Usage"
Staff and Administrators shall be able to view statistical charts detailing the
following:
.RS
.IP \[bu]
Times Lab Most Utilized
.IP \[bu]
Days Lab Most Utilized
.IP \[bu]
Classes Lab Most Utilized
.RE
.Reqr "Staff can only View Reports for their Own Classes"
Staff shall only be able to view reports for classes they are responsible for
teaching.
.Reqr "Administrators can View All Reports"
Administrators shall be able to view reports for all classes, and shall also be
able to view the following reports:
.RS
.IP \[bu]
Professors Lab Most Utilized
.RE
.Endsup
.Superhead "Administrative Functions (Staff/Administrator/System Administrator)"
.Reqr "User must be in User Mode"
The user shall be currently logged in to User Mode to use administrative features.
.Reqr "Staff may Promote/Demote Tutors"
Staff shall be able to promote Students to Tutors, and demote Tutors to
Students.
\# @TODO Should the Class/Section divide be reflected?
\#	 Options:
\#		1. Staff can add Classes and Sections that they teach
\#		2. Staff can add Sections, but only Administrators can add
\#			Classes.
\# ANSWER: Yes. Choose option #2, and add a class-based report for the admins.
.Reqr "Staff can Add Their own Classes"
Staff shall be able to add/remove classes that they teach. Each class shall be
assigned a term that it occurs during.
\# @TODO Should staff be able to remove classes that people have clock in/outs for?
.Reqr "Administrators are Staff with Additional Privileges"
Administrators shall be able to do everything Staff can do.
.Reqr "Administrators can Add/Remove Staff"
Administrators can add/remove staff from the system.
.Reqr "System Administrators can Create Terms"
System Administrators shall be able to create terms for classes to be assigned
to.
\# @TODO How do we want to handle 1/3 term classes?
.Reqr "System Administrators can Promote/Demote Administrators"
System Administrators shall be able to promote Staff to Administrators, and
demote Administrators to Staff.
.Reqr "System Administrators can Set Time Bounds"
System Administrators shall be able to set bounds on the times tutors can be in
the labs, such as "No tutors before noon or after 7:00 PM"
.Endsup
.Endsub
.Subhead "Performance Requirements"
.Para
The system shall be able to handle at least 20 simultaneous users, and at least
2 simultaneous requests for statistical charts.
.Endsub
.Subhead "Logical Database Requirements"
The database is the main repository for all the information the application
stores. The database stores three main things:
.RS
.nr ldbnum 0 1
.IP \n+[ldbnum].
Users
.IP \n+[ldbnum].
Classes
.IP \n+[ldbnum].
Lab Usage
.RE
.Para
Users are any user of the system. For every user, we assign them a unique
numeric ID, and then collect the following information about them:
.RS
.IP \[bu]
Student ID number
.IP \[bu]
Real Name
.IP \[bu]
Email Address
.IP \[bu]
User Role
.RE
See Figure 6 for an E/R diagram of the system.
.KF L
.sp 1.5in
.PSPIC erdiagram.eps
.ce 1
.B "Fig. 6: " "E/R Diagram of the System."
.KE
.Endsub
.Subhead "Design Constraints"
.Para
The system does not have any external standards or regulations it must comply
with.
.Superhead "Reliability"
.Para
The system shall be online 99.9% of the time, except for announced and scheduled maintenance.
.Endsup
.Superhead "Availability"
.Para
The system shall be able to recover from a system failure without human
intervention.
.Endsup
.Superhead "Security"
.Para
The system shall ensure the database is not accessible from the network, and
shall use HTTPS for all User Mode traffic to prevent leaking of user credentials
or data.
.Para
The system shall also log the use of Administrative actions to provide
accountability for what happens to the system.
.Endsup
.Endsub
.Endsec
