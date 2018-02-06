.Section "Software Design Description"
.Subhead "Component 1: Web Interface"
\# @TODO Ask Adam to help with this part.
\#.DS
\#.PSPIC "kiosklogin.ps" 
\#.ce 1
\#\fBFig. 2:\fPKiosk Mode Login
\#.DE
.Para
The job of the web interface is to provide a way for the user to interact with
the rest of the system.
.Superhead "Component Interfaces"
This component interacts with both the end-user and the database, getting input
and output from both.
.Endsup
.Superhead "Component Design Description"
The web interface has three main components:
.RS
.IP "User Mode"
User mode is the component that the staff will interact with the most. Students
will also interact with it occasionally, mainly to use the question and answer
system. User mode is more a container for three subcomponents:
.RS
.IP "Question & Answer"
The question and answer system will allow for students to ask questions, tutors
and staff to respond to those questions, and then for students to ask follow-up
questions as well.
.IP "Reporting"
The reporting system provides the usage reports for the labs. These include:
.RS
.Bullet
Lab Utilization Per Section
.Bullet
Lab Utilization Per Time Period
.Bullet
Lab Utilization Per Professor
.RE
.IP "User Management"
The user management provides the capability for staff and administrators to
manage the users of the system, including who tutors are, who staff are, and who
administrators are; among other things.
.RE
.IP "Kiosk Mode"
Kiosk mode is the component that will be the one that students interact with the
most. It allows the students and tutors to clock in and out of specific lab
sections, and provides the database with the information necessary to provide
analytic reports.
.IP "Login"
The login component is the first component that the user sees and the one that
is responsible for allowing the users to use the other components. Upon
using the system for the first time, the user will directed to the User
Registration sub-component; otherwise, they will be directed to the component that
they selected.
.RS
.IP "User Registration"
User Registration is responsible for taking first time users and associating
their real name, email and username with their student ID number.
.RE
.Endsup
.Superhead "Workflows and Algorithms"
.RE
.RE
.RE
.DS L
.PSPIC "webflow.eps"
.ce 1
\fBFig. 1:\fPWeb Interface Flow Diagram
.DE
.RS
.RS
.RS
.Endsup
.Endsub
.Subhead "Component II: Database"
.Para
The database serves as the place where all of the data that LabAssist uses is
stored and analyzed.
.Superhead "Component Interfaces"
This component interfaces with both the web interface and the mailer. It gets
information from the web interface, and then sends information out to both the
web interface and the mailer.
.Endsup
.Superhead "Component Design Description"
The database is stored as a collection of SQL tables split into the following
categories:
.RS
.IP "Users"
This group of tables is concerned with storing users and what roles they have.
.IP "Class Usage"
This group of tables is concerned with storing data about classes and when
people are using the lab.
.IP "Question & Answer"
This group of tables is concerned with storing the data necessary for the
question and answer system to work.
.IP "Scheduling"
This group of tables is concerned with storing the data necessary for the tutor
scheduling feature to work.
.RE
.Endsup
.Superhead "Workflows and Algorithms"
.RE
.RE
.RE
.DS L
.PSPIC "sql-depend.eps"
.ce 1
\fBFig. 2:\fP Table Category Dependancies
.DE
.RS
.RS
.RS
For a more detailed description of the database, see the attached database
schema.
.Endsub
.Subhead "Component III: Background Mailer"
.Para
The job of the background mailer is, as previously noted, to connect to the
database, retrieve messages, merge them and then send out the merged messages.
.Superhead "Component Interfaces"
This component interfaces with both the database and an external SMTP server,
using the database to retrieve messages to send, and the SMTP server to send the
messages to users they are supposed to go tgo.
.Endsup
.Superhead "Component Design Description"
The mailer is designed as a java application split into three main parts:
Grabber, Batcher and Sender. The roles of the components are as follows
.RS
.IP Grabber
The grabber component functions to retrieve messages from the database and
convert them into Message objects.
.IP Batcher
The batcher component functions to take a bunch of Message objects, and then
combine compatible messages to cut down on the total number of mail messages
sent.
.IP Sender
The sender takes Message objects and converts them into SMTP messages to send
them.
\# @TODO Add diagrams
.RE
.Endsup
.Superhead "Workflows and  Algorithms"
.Para
To allow for easier editing of message types and to simplify the addition of
more message types, the mailer uses a text-based template for each message type
with placeholders that will be filled in by the body variables from the message.
.Para
To cut down on the amount of notifications sent, the mailer uses a merging
algorithm consisting of performing the following steps on every message:
.RS
.nr stepcount 0 1
.IP \n+[stepcount].
Get the stored messsage of the correct type for the recipients of the current
message, or create one if there is no stored message for the recipients of the
current message.
.IP \n+[stepcount].
Merge the body variables of the current message into the stored message. The way
this happens is specific to the type of the message, but in general it is done
by appending the two variables together, possibly with a seperator.
.RE
.Endsub
.Endsec
