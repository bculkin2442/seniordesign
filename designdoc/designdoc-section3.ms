.Section "Software Design Description"
.Subhead "Login"
\#.DS
\#.PSPIC "kiosklogin.ps" 
\#.ce 1
\#\fBFig. 2:\fPKiosk Mode Login
\#.DE
.Para
This major component handles logging users into the system via one of two
authentication methods. First time users will be prompted to complete a
registration form handled by the registration subcomponent when logging in
from either authentication method.
.Superhead "Component 1: Login"
This component exists solely to allow users gain access to the LabAssist system.
This page is the default page on the server, as such all users start with this
component. The login component has two methods. Method 1 is labeled Kiosk login
and requires only an Employee ID or Student ID as input. Method 1 only grants
access to the clock-in/clock-out functionality. Method 2 is labeled User Login
requiring both a username and password. Method 2 only grants access to the
Portal component of the system.  
.Suprahead "Component Interfaces"
.KS
.UL "Logic"
.Gloss "attemptPassLogin()"
Checks username and password combination by binding the LDAP server with the
supplied credentials.
.Gloss "attemptKioskLogin()"
Queries to see if Employee/Student ID is registered. Internally calls
kioskLoginCheck() and directs user to either registration or to the clock in/out
system.
.Gloss "isRegistered()"
Queries database to determine whether a database record exists for a user
attempting to login.
.Gloss "kioskLoginCheck()"
Queries the database to determine if a record exists for the given ID.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration form and any generated errors. Inserts
dynamic code into static HTML code prints.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
.Para
The component is implemented as an Action-Domain-Responder model where login.php
would be the action, login-logic.php the domain, and login-page.php the
responder. The register action first checks to ensure that the user is currently
logged into the system via a session variable and redirects all users to the
clock-in/clock-out component if the kiosk flag is set or to the portal component
if the userLogin flag is set. 
.Para
When using method 1, the domain queries the database to determine if the user has
an account already registered. If not, the system redirects to the register
component. If the user is already registered, users are directed to the
clock-in/clock-out component.
.Para
When using method 2, the domain queries the LDAP server with the supplied
username and password pair via a bind call. If the bind fails, the responder
displays an appropriate message. If the bind succeeds, the domain then queries
the database to determine if a tuple exists with the appropriate user
information. If no tuple is found then the domain redirects to the register
component, otherwise the domain redirects to the portal component.
.Endsupr
.Endsup
.Superhead "Component 2: Register"
This component exists solely to register users with the LabAssist system. Users
are directed to this component when a valid login attempt is made with the login
component, and no record is found in the database that matches.
.Suprahead "Component Interfaces"
.KS
.UL "Logic"
.Gloss "restoreForm()"
Restore previous values if form reloads.
.Gloss "generateRegistration()"
Generates the HTML registration form with values provided by the LDAP
controller.
.Gloss "attemptRegistration()"
Attempts to register the user. Performs input validation and internally calls
insertRegistration.
.Gloss "insertRegistration()"
Queries the database attempting to add user information to the database.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration and generated errors, and inserts the
dynamic code into a static template and prints it
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
The component is implemented as an Action-Domain-Responder model where
user_registration.php would be the action, user_registration-logic.php the
domain, and user_registration-page.php the responder. The register action first
checks to ensure that the user has only come from the login system via a session
variable and redirects all users to the login screen if the variable is empty or
not set. Next, the domain queries the LDAP server for basic user information
such as email, and name by reverse looking up the information they provided at
the login form submission. The responder then prints the pre-filled form to the
screen. On form submission the action page informs the domain to attempt to
register the user. On success, the user will proceed on to the next component in
the sequence. On failure the user may update the input and try again or cancel.
Cancelling returns the user to the login screen. At no point is a password ever
stored in the local database before, during, and after registration. 
.Endsupr
.Endsup
.Superhead "Workflow"
.DS L
.PSPIC "login-diagram.eps"
.ce 1
\fBFig:\fP Login Sequence Diagram
.DE
.Endsup
.Endsub
.Subhead "Clock-in/Clock-out"
This major component handles logging the time in/time out as well as the section
for students arriving to and from a lab.
.Superhead "Component Clock In/Out"
Students arrive here from a successful kiosk mode login, and are given the
option to clock-in if not already clocked in, or the ability to clock out if
already clocked in. This component is only accessible from the kiosk mode login.
.Suprahead "Component Interface"
.KS
.UL "Logic"
.Gloss "generateClockinClockoutForm()"
Calls an internal function to generate the form. Renders either clock in or
clock out form based on results from isClockin().
.Gloss "isClockin()"
Queries database to check for outstanding user clock-ins. Returns a tri-valued
int (true/false/error).
.Gloss "genClockoutForm()"
Generates the form for a clock out.
.Gloss "genLab(department)"
Creates the department listing for the clock-in form. Takes the previous values
as a parameter for restoration if needed.
.Gloss "genClass(department, class)"
Creates the class listing for the clock-in form based on a department. Takes the
previous class as a parameter for restoration if needed.
.Gloss "attemptClockinClockout()"
Master function that calls attemptClockin() or attemptClockout() internally
depending on the result of isClockin().
.Gloss "attemptClockin()"
Queries the database attempting to insert a record of a clock in.
.Gloss "attemptClockout()"
Queries the database attempting to update the appropriate outstanding clock-in
with a clock-out.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration and generated errors, and inserts the
dynamic code into a static template and prints it.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
Users arrive at this component after a successful kiosk login. The component is
implemented as an Action-Domain-Responder model where tutor_session.php would be
the action, tutor_session-logic.php the domain, and tutor_session-page.php the
responder. The action module makes an initial check to ensure the user arrived
from a successful kiosk login and then queries the domain to render the form.
The domain checks the database to determine if the user has an outstanding clock
in, if so, then the clock out form is generated and passed to the responder. If
the user does not have an outstanding login, the login page is generated and
passed to the responder. The generated page contains two dropdowns, one for
department and one for the class. After the user fills out the form and clicks
submit, the action module calls attempt ClickinClockout() to insert or modify
the database. If cancel is chosen, the action module redirects the user to the
login form. 
.Endsupr
.Endsup
.Superhead "Workflow"
.DS L
.PSPIC "clockinout-diagram.eps"
.ce 1
\fBFig:\fP Clock In/Out Sequence Diagram
.DE
.Endsup
.Endsub
.Subhead "Portal"
This major component contains the core functionality of this project. Namely,
this is the ability to access the Question and Answer system, as well as
reporting, scheduling, and management functionality. Access to this major
component is limited to users who have successfully logged into user mode.
.Superhead "Component 1: Home"
Displays important information and updates to the user, such as a notification
of responses to questions.
.Suprahead "Component Interface"
.KS
.UL "Logic"
.Gloss "generateBasicNotifications()"
Generates basic notifications, such as new replies.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printPortalHead()"
Prints the visible header bar for the portal.
.Gloss "printSideBar(userinfo, navigation)"
Prints the sidebar containing basic user information, as well as a navigation
bar.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration form and any generated errors. Inserts the
dynamic code into a static template and prints it.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
This page serves as the default landing page after a user logs into the system
from the user login. It is implemented as an Action-Domain-Responder model where
portal-home.php would be the action, portal-logic, the domain, and portal-page
as the responder. The action page performs a check to make sure the user is
logged in and redirects them to the login page if they are not. The domain
queries the database for any notifications and generates a templated response
that gets passed to the responder. The responder then displays the output to the
user. No input is taken from the user on this page. 
.Endsupr
.Endsup
.Superhead "Tutor Schedules"
This component displays the current lab schedules.
.Suprahead "Component Interface"
.KS
\# @TODO 02/08/18 Ben Culkin :LogicBox
\# 	Add a macro to do this KS + UL bit
.UL "Logic"
.Gloss "generateForm()"
Calls internal functions to generate the form.
.Gloss "genDepartment()"
Generates a dropdown for the user to choose the desired lab section.
.Gloss "querySchedule()"
Retrieves the schedule from the database for display.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printPortalHead()"
Prints the visible header bar for the portal.
.Gloss "printSideBar(userinfo, navigation)"
Prints the sidebar containing basic user information, as well as a navigation
bar.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration form and any generated errors. Inserts the
dynamic code into a static template and prints it.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
This page is accessable from any location by a valid user. A valid user for this
page is defined as a user who has successfully logged in via the portal system.
The action page checks that a user has successfully logged in and redirects them
to the login page if they are not. The domain queries the database for a list of
departments and generates a dropdown populated with the departments for the
responder. The responder then displays the form to the user. Once a selection
has been made, the action page notifies the domain to create a schedule listing
for the specified department. The result is passed to the responder for
displaying. 
.Endsupr
.Endsup
.Superhead "Q/A System"
This component allows users to submit questions, and allows tutors to respond to
a student's questions.
.Suprahead "Component Interface"
.KS
.UL "Logic"
.Gloss "generateForm()"
Calls internal functions to generate the form.
.Gloss "createQuestion()"
Generates a form for the creation of a new question.
.Gloss "generateListing()"
Generates a listing of all threads created by the user.
.Gloss "generateThread()"
Generates a specified thread.
.Gloss "queryThreads(user)"
Queries listings of threads by a user.
.Gloss "queryThread(id)"
Requests a thread, by ID, from the database.
.Gloss "queryCreateQuestion()"
Inserts the user question into the database.
.Gloss "queryCreateResponse(id)"
Inserts a response to a question into the database.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printPortalHead()"
Prints the visible header bar for the portal.
.Gloss "printSideBar(userinfo, navigation)"
Prints the sidebar containing basic user information, as well as a navigation
bar.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration form and any generated errors. Inserts the
dynamic code into a static template and prints it.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
This page is accessable from any location by a valid user. A valid user for this
page is defined as a user who has successfully logged in via the portal system.
The action page checks that a user has successfully logged in and redirects them
to the login page if they are not. The domain queries the database for a list of
threads for the responder. The responder then displays the form to the user.
Once a selection has been made, the action page notifies the domain to generate
either the new question form, or display the thread. The result is passed to the
responder for displaying. If a new question is submitted, or a new response is
generated the system will then attempt to update the database with the new
records. The thread that was updated/created will subsequently be generated by
the domain and passed to the responder for viewing. 
.Endsupr
.Endsup
.Superhead "User Account Settings"
This page allows the user to view their user information and update any
modifiable fields.
.Suprahead
.KS
.UL "Logic"
.Gloss "generateForm()"
Calls internal functions to generate the form.
.Gloss "updateUserInfo()"
Attempts to update the user information in the database.
.Gloss "getUserInfo()"
Retrieves the user information from the database.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printPortalHead()"
Prints the visible header bar for the portal.
.Gloss "printSideBar(userinfo, navigation)"
Prints the sidebar containing basic user information, as well as a navigation
bar.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration form and any generated errors. Inserts the
dynamic code into a static template and prints it.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
This page is accessable from any location by a valid user. A valid user for this
page is defined as a user who has successfully logged in via the portal system.
The action page checks that a user has successfully logged in andredirects them
to the login page if they are not. The domain queries the database for the
current user's information before passing to the responder. The responder then
displays the form to the user. Once a change has been made, the action page
notifies the domain to update the database accordingly. Upon successful
submission or cancelation, the user is redirected back to the home.
.Endsupr
.Endsup
.Superhead "Tutor Scheduling"
Not to be confused with Tutor Schedules, this component modifies and generates
the schedules displayed by the aforementioned component.
.Suprahead "Component Interface"
.KS
.UL "Logic"
.Gloss "generateForm()"
Calls internal functions to generate the form.
.Gloss "genDepartment()"
Generates a dropdown for the user to choose the desired lab section.
.Gloss "querySchedule()"
Retrieves the schedule from the database.
.Gloss "genCreate()"
Generates the form for creating a new entry.
.Gloss "updateEntry()"
Generates the form for updating an entry.
.Gloss "attemptCreate()"
Attempts to insert a new entry into the database.
.Gloss "attemptUpdate()"
Attempts to update a database entry.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printPortalHead()"
Prints the visible header bar for the portal.
.Gloss "printSideBar(userinfo, navigation)"
Prints the sidebar containing basic user information, as well as a navigation
bar.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration form and any generated errors. Inserts the
dynamic code into a static template and prints it.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
This page is accessable from any location by a valid user. A valid user for this
page is defined as a user who has successfully logged in via the portal system
and a user with the role of tutor or greater. The action page checks that a user
has successfully logged in andredirects them to the login page if they are not.
The domain queries the database for the current department schedule before
passing to the responder. The responder then displays the form to the user. Once
a change has been made, the action page notifies the domain to update the
database accordingly. Upon successful submission or cancelation, the user is
redirected back to the edit schedule page.
.Endsupr
.Endsup
.Superhead "Manage Users"
.Suprahead "Component Interface"
.KS
.UL "Logic"
.Gloss "displayAll()"
Calls internal functions to generate the base form with a listing of users.
.Gloss "genEditForm()"
Generates a 'edit user' form to be displayed. Calls formattedUserInformation
internally.
.Gloss "formattedUserInformation()"
Fills the edit form with the user information.
.Gloss "generateTable()"
Formats list of users into a table listing of users.
.Gloss "getAccessLevelSelect(currentUserRole)"
Creates a dropdown menu of roles that the current user is allowed to assign.
.Gloss "getDepartmentList(currentDepartment)"
Creates a dropdownm menu of available departments to assign the user to.
.Gloss "filterRoleList(array)"
Processes an arrary of available roles and returns the roles the current user is
available to assign.
.Gloss "getDetailedUserInfo(userid)"
Pulls information of the user being edited.
.Gloss "getUserList()"
Queries database for a list of users.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printPortalHead()"
Prints the visible header bar for the portal.
.Gloss "printSideBar(userinfo, navigation)"
Prints the sidebar containing basic user information, as well as a navigation
bar.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration form and any generated errors. Inserts the
dynamic code into a static template and prints it.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
This page is accessable from any location by a valid user. A valid user for this
page is defined as a user who has successfully logged in via the portal system
and a user with the role of staff or greater. The action page checks that a user
has successfully logged in andredirects them to the login page if they are not.
The domain queries the database for the current listing of users before passing
to the responder. The responder then displays the form to the user. Once a the
edit user button is clicked, the action page notifies the domain to generate the
edit user form for the responder to display. Once an edit has been submitted the
domain updates the database accordingly. Upon successful submission or
cancelation, the user is redirected back to the edit user page.
.Endsupr
.Endsup
.Superhead "Manage Classes"
.Suprahead "Component Interface"
.KS
.UL "Logic"
.Gloss "displayAll"
Calls internal functions to generate the base form with a listing of classes.
.Gloss "genEditForm()"
Generates an 'edit class' form to be displayed. Calls formattedClassInformation
internally.
.Gloss "formattedClassInformation()"
Fills the edit form with class information.
.Gloss "generateTable()"
Formats a list of class into a table that lists those classes.
.Gloss "getDepartmentList(currentDepartment)"
Creates a dropdown of available departments to assign the class to.
.Gloss "getDetailedClassInfo(classid)"
Pulls information of the class being edited.
.Gloss "getClassList()"
Queries database for a list of classes.
.Gloss "genCreate()"
Generates the page to create a new class.
.Gloss "attemptCreate()"
Attempts to insert a new entry into the database.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printPortalHead()"
Prints the visible header bar for the portal.
.Gloss "printSideBar(userinfo, navigation)"
Prints the sidebar containing basic user information, as well as a navigation
bar.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration form and any generated errors. Inserts the
dynamic code into a static template and prints it.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
This page is accessable from any location by a valid user. A valid user for this
page is defined as a user who has successfully logged in via the portal system
and a user with the role of staff or greater. The action page checks that a user
has successfully logged in andredirects them to the login page if they are not.
The domain queries the database for the current listing of classes before
passing to the responder. The responder then displays the form to the user. If
the edit class button is clicked, the action page notifies the domain to
generate the edit class form for the responder to display. Once an edit has been
submitted the domain updates the database accordingly. Upon successful
submission or cancelation, the class is redirected back to the edit class page.
If the add class button is clicked, the domain generates the create class form
and passes it to the responder to display to the user. On a submit, the domain
attempts to insert the record into the database. If successful or the user
canceles sumbission at any point, the user is redirected to the manage classes
page. 
.Endsupr
.Endsup
.Superhead "Manage Class Sections"
.Suprahead "Component Interface"
.KS
.UL "Logic"
.Gloss "displayAll()"
Calls internal functions to generate the base form with a listing of sections.
.Gloss "genEditForm()"
Generates an 'edit section' form to be displayed. Calls
formattedSectionInformation internally.
.Gloss "formattedSectionInformation()"
Fills the edit form with the section information.
.Gloss "generateTable()"
Formats list of sections into a tabular listing of sections.
.Gloss "getDepartmentList(currentDepartment)"
Creates a dropdown of available departments to assign the section to.
.Gloss "getDetailedSectionInfo(sectionid)"
Pulls the information of the section being edited.
.Gloss "getSectionList()"
Queries database for the list of sections.
.Gloss "genCreate()"
Generates the page to create a new section.
.Gloss "attemptCreate()"
Attempts to insert a new section into the database.
.KE
.KS
.UL "Display"
.Gloss "printHeader()"
Prints static HTML code for the page start.
.Gloss "printStartBody()"
Prints static HTML code for the opening body tags.
.Gloss "printPortalHead()"
Prints the visible header bar for the portal.
.Gloss "printSideBar(userinfo, navigation)"
Prints the sidebar containing basic user information, as well as a navigation
bar.
.Gloss "printForm(html, error)"
Takes the dynamic HTML registration form and any generated errors. Inserts the
dynamic code into a static template and prints it.
.Gloss "printEndBody()"
Prints static HTML code for closing the page.
.KE
.Endsupr
.Suprahead "Component Design Description"
This page is accessable from any location by a valid user. A valid user for this
page is defined as a user who has successfully logged in via the portal system
and a user with the role of admin or greater. The action page checks that a user
has successfully logged in andredirects them to the login page if they are not.
The domain queries the database for the current listing of sections before
passing to the responder. The responder then displays the form to the user. If
the edit section button is clicked, the action page notifies the domain to
generate the edit section form for the responder to display. Once an edit has
been submitted the domain updates the database accordingly. Upon successful
submission or cancelation, the section is redirected back to the edit section
page. If the add section button is clicked, the domain generates the create
section form and passes it to the responder to display to the user. On a submit,
the domain attempts to insert the record into the database. If successful or the
user canceles sumbission at any point, the user is redirected to the manage
sections page. 
.Endsupr
.Endsup
.Endsub
.Subhead "Database"
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
.Endsup
.Superhead "Class Descriptions"
.Para
The mailer is composed of three main 'operating' classes, and two data classes.
The operating classes are Mailer, MessageBatcher, and MessageGrabber, using
Message and MessageType for data.
.Endsup
.Endsub
.Endsec
