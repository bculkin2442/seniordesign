\# Double-space lines
.nr vs 24p
\# Set in 12pt font
.nr ps 12p
\# Load macros
.so designdoc.tmac
\# Number pages after title page
.P1
\# Date in footers
.DA
\# No date on title page
.ND ""
\# Title page
.RP no
\&
.sp 2in
.TL
LabAssist
.br
Design Document
.sp 2in
.AU
Adam Cantrell
.AI
West Virginia University Institute of Technology
.AU
Benjamin Culkin
.AI
West Virginia University Institute of Technology
.sp 1in
Version: 1
.AB no
.AE
\# Load sections
.so designdoc-section1.ms
.so designdoc-section2.ms
.so designdoc-section3.ms
\# Title of contents will get put in front on print-out
.bp
\&
.bp
.TC
