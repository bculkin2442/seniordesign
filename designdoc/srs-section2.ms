.Section "Software Architecture Overview"
.Para
LabAssist is built from three main components: A web interface for interacting
with that database, a database that stores information and prepares statistics
from it, and a background job that sends mail notifications.
.Para
The only component that the users need know exist is the web interface. It
provides users the ability to access all of the provided features of the
software, and it does this by interacting with the database; both sending data
to update the database, and running queries to retrieve data.
.Para
The database is the central component of the system, by virtue of being the
place where all of the data that the system needs is stored and processed.
.Para
The background job is a task that is set to run every twenty to thirty minutes.
Its job is to retrieve any pending notifications from the database, merge
together any messages that can be merged, and then send out the merged
notifications via email.
\# @TODO insert an interface diagram.
.Para
The system is designed to run off of any system running the following:
.RS
.Bullet
PHP 7
.Bullet
Web Server
.Bullet
Postgres 9.6
.RE
.Endsec
