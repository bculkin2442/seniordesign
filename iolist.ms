.de LI
.	IP \[bu]
..
.RP
.TL
Input/Output for Metronome
.AU
Benjamin Culkin
.AI
West Virginia University Institute of Technology
.AU
Adam Cantrell
.AI
West Virginia University Institute of Technology
.AB no
.AE
.bp
.NH 1
Students (End Users)
.RS
.NH 2
Inputs
.RS
.LI
(Login/Logout) Student ID Number
.LI
(Login/Logout) Student Name
.RS
.LI
Entered on first time login, stored in association with the ID number
.RE
.LI
(Clock In/Out) Section student is here for help with.
.LI
(Clock In/Out) Tutor student is getting help from.
.LI
(Question/Answer) Student question.
.RE
.NH 2
Outputs
.RS
.LI
(Clock In/Out) Notification of student status (Clocked In/Out)
.LI
(Clock In/Out) Entry in database containing information about lab usage.
.RS
.LI
Time/date
.LI
User ID
.LI
Section ID
.LI
(Optional) Tutor ID
.RE
.LI
(Question/Answer) Question posted to list of pending questions.
.RE
.RE
.NH 1
Tutors
.RS
.NH 2
Inputs
.RS
.LI
(Login/Logout) Tutor ID number
.LI
(Login/Logout) Tutor name
.RS
.LI
Entered on first time login, stored in association with the ID number
.RE
.LI
(Scheduling) Tutor schedule
.LI
(Question/Answer) Tutor contact information
.LI
(Question/Answer) Response to question
.RE
.NH 2
Outputs
.RS
.LI
(Login/Logout) Notification of tutor status (Logged In/Out)
.LI
(Login/Logout) Entry in database containing information about lab usage.
.RS
.LI
Time/data
.LI
Tutor ID
.RE
.LI
(Question/Answer) Notifications about pending questions
.LI
(Question/Answer) Responses added to student questions
.RS
.LI
Student questions moved from pending to answered
.RE
.RE
.RE
.NH 1
Faculty (Administrators)
.RS
.NH 2
Inputs
.RS
.LI
(Login/Logout) Faculty ID number
.LI
(Login/Logout) Teacher Name
.RS
.LI
Entered on first time login, stored in association with the ID number
.RE
.LI
(Class Management) Add/Remove Classes
.RS
.LI
(Optional) Associate department with section
.RE
.LI
(User Management) Add/Remove Tutors
.RS
.LI
(Optional) Add/Remove sections from tutors
.RE
.LI
(Statistics) Request Usage Reports
.RS
.LI
Per Section
.LI
Per Clas
.LI
Per Tutor
.LI
Per Student
.LI
Overall
.RE
.RE
.NH 2
Outputs
.RS
.LI
(Login/Logout) Mark Faculty as logged in/out
.LI
(Class Management) Make changes to section lists
.LI
(User Management) Make changes to tutor lists
.LI
(Statistics) Provide requested reports
.RS
.LI
Graphical
.LI
(Optional) Tabular
.LI
Raw Data
.RE
.RE
.RE
.NH 1
System Administrators
.RS
.NH 2
Inputs
.RS
.LI
(User Management) Add/Remove Teachers
.RS
.LI
(Optional) Associate teacher with department
.LI
(Optional) Mark Teacher as department head
.RE
.LI
(Class Management) Add/Remove Terms
.RE
.NH 2
Output
.RS
.LI
(User Management) Make changes to teacher lists.
.LI
(Class Management) Make changes to term lists.
.RE
.RE
