\# Double-space lines
.nr vs 24p
\# Set in 12pt font
.nr ps 12p
\# Load macros
.so srs.tmac
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
CS 480
.br
Software Requirements Specification Document
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
.so srs-section1.ms
.so srs-section2.ms
.so srs-section3.ms
.so srs-section4.ms
\# Title of contents will get put in front on print-out
.bp
\&
.bp
.TC
