.Section "Introduction"
.Para
This section gives a scope description and overview of the SRS document. This
section also provides the purpose of this document.
.Subhead "Purpose"
.Para
The purpose of this document is to provide the detailed description for the "Lab
Assist" software. This document illustrates the purpose of the system. It also
defines the system constraints, interfaces and interactions of the software. The
primary purpose is to provide a proposition to a customer for approval and serve
as a guide for future documentation and overall design.
.Endsub
.Subhead "Scope"
.Para
LabAssist is a web-based application designed to provide students with an
additional point of contact with instructors and tutors. The system will also
offer a statistical reporting system to enable faculty and tutors to tailor lab
hours to student needs.
.Para
Students login to the system through a web portal to indicate the classes and
subjects that they are seeking help in. Additionally the software will provide a
Question and Answer system for students that require additional help. This
information is then relayed to a database where the statistical reporting system
will do analysis and provide reports to professors and staff. For security
purposes, there will be two separate login portals. One for kiosk use and the
second for user login.
.Para
Furthermore, the base application will not support the ability to schedule
tutors/staff automatically based on availability. The system will interface
with the University authentication system for user authorization/authentication.
.Endsub
.Subhead "Definitions, Acronyms, and Abbreviations"
.Defn "Admin/Administrator"
An individual with the ability to see statistical information, manage tutors,
manage staff, and see statistical information for everyone in the same
department, as well as respond to questions in the Question/Answer system.
.Defn "Department"
Division of organizational structure. Examples are Math, Computer Science and
Mechanical Engineering.
.Defn "Kiosk"
A login portal that accepts logins with a user ID for use with lab arrival
and departure logging.
.Defn "LDAP"
Lightweight Directory Access Protocol. A computer protocol used for
communicating with directory systems, often containing user information.
.Defn "SMTP"
Simple Mailbox Transfer Protocol. A computer protocol used for sending email
messages.
.Defn "Stake Holder"
Individuals who have any form of interaction with the system but
who is not a developer.
.Defn "Staff"
A person with the ability to view statistical information and manage classes
taught by themselves, as well as respond to questions in the Question/Answer
system.
.Defn "Student"
An individual seeking help in class(es) or subject(s).
.Defn "SysAdmin/System Administrator"
Individual with the ability to create terms and
manage Administrators, but lacks ability to view statistical reporting.
.Defn "Term"
Current academic period. Ex. Fall, Spring, Winter, Summer.
.Defn "Tutor"
An individual employed and given permission to respond to students.
.Defn "PHP"
Server-side scripting language used for web development.
.Defn "Web-Portal"
User interface for system users.
.Endsub
.Subhead "References"
.nr ref 0 1
.Refr
Apache.org. (2017). "Welcome to The Apache Software Foundation!." [online] Available at: https://www.apache.org/ [Accessed 27 Sep. 2017].
.Refr
Php.net. (2017). PHP: "Hypertext Preprocessor." [online] Available at: http://php.net/ [Accessed 27 Sep. 2017].
.Endsub
.Subhead "Overview"
.Para
Section two of this document provides an overview of system functionality and
interactions. Section two also defines the stakeholders and system constraints
and assumptions for the product. This section provides the information that is
most critical to potential consumers/users of the product. 
.Para
Section three details the requirement specification and defines the system
interfaces. This section is tailored to potential developers of this product.
.Para
Section four illustrates the prioritization of the requirements and the proposed
stages of release.
.Para
Section five provides the identity of the approvers of the software requirement
specification document. 
.Endsub
.Endsec
