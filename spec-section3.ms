\# Print a heading, and mark it in the ToC
.de Head
.NH 1
\\$1
.PP
.XS
\\$1
.XE
..
\# Print a subheading, and mark it in the ToC
.de Subhead
.NH 2
\\$1
.PP
.XS
\t\\$1
.XE
..
\# Print a 3rd level heading, and mark it in the ToC
.de Superhead
.NH 3
\\$1
.PP
.XS
\t\t\\$1
.XE
..
\# Print a bulleted item
.de Bullet
.IP \[bu]
..
.P1
.ND ""
\##############################################################################
\# Section starts here
\##############################################################################
.Head "Specific Requirements"
.Subhead "External Interfaces"
Metronome has one main external interface, a website. This website is the main
way everyone will interact with the project, allowing them to access all the
functions appropriate for their role.
.Subhead "Functions"
Metronome has three main functions.
.RS
.Bullet
Allow teachers to keep track of student usage of help labs.
.Bullet
Allow students an easy way to ask questions of tutors/professors.
.Bullet
Provide statistical reports to teachers about usage of the help labs.
.RE
.Subhead "Performance Requirements"
The performance requirement for the website should be that the pages should load
almost as fast as the network allows them to load.
.Subhead "Logical Database Requirements"
.Subhead "Design Constraints"
.Superhead "Standards Compliance"
Since Metronome does not store any sensitive data, and there is no general
standard for what it does, there are no standards we need to comply with.
.Subhead "Software System Attributes"
.Superhead "Reliability"
.Superhead "Availability"
.Superhead "Security"
.Superhead "Maintainability"
.Superhead "Portability"
.Subhead "Organizing the Specific Requirements"
.Superhead "System Mode"
.Superhead "User Class"
.Superhead "Objects"
.Superhead "Feature"
.Superhead "Stimulus"
.Superhead "Response"
.Superhead "Functional Hierarchy"
.Subhead "Additional Comments"
.bp
\# Print table of contents
.TC
