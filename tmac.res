.ll \n[.l]u+1i
.
.nr TITLE.ps 25
.nr HEADING.ps 15
.
.\" what color are headers and extra markings
.ds RESUME.cl #009688
.ds RESUME.grey.cl #dddddd
.
.\" How big is the gap between columns
.nr RESUME.gap 1c
.
.\" Where does the first column end?
.
.nr RESUME.ll \n[.l] \"total line length
.nr RESUME.margin 1c
.nr RESUME.split 3.4i
.
.po -\n[RESUME.margin]u
.\" internal macro
.de RATINGS.loop
.	nr a.1 (\\$1-1)
.	nr a.2 (\\$2-1)
.	\" if we have marked the right number of bullets
.	ie (\\n[a.1]<0) \
.		cl \\*[RESUME.grey.cl] \" Turn bullets grey
.	\" else
.	el \
.		cl \\*[RESUME.cl] \" Leave mark bullet blue
.	ps +7
\(bu
.	ps
.	if (\\n[a.2]>0) \
.		RATINGS.loop \\n[a.1] \\n[a.2]
..
.
.\" Used for rating your skill level
.\" RATINGS "thing to be rated" "rating"
.\" RATINGS "Programming" "3"
.de RATINGS
\\$1
.	sp -1
.	ad r
.	RATINGS.loop \\$2 5
.	cl #000000
.	br
.	ad l
..
.de TITLE
.	sp 4
.	ps \\n[TITLE.ps]
.	ft TITLE
\\$*
.	ft
.	ps
.	br
..
.
.\" Description of yourself
.\" DESC Mother Fucking Boss
.de DESC
.	cl \\*[RESUME.cl]
.	ft TITLE
\\$*
.	ft
.	cl
..
.
.\" Heading for a section
.\" HEADING LIFE PHILOSOPY
.de HEADING
.	br
.	cl \\*[RESUME.cl]
.	ps \\n[HEADING.ps]
.	ft TITLE
\\$*
.sp -0.6
.\" use remaining line length for right side
\l'\\n[.l]u'
.sp 0.5
.	ft
.	ps
.	cl
.	br
..
.de →
.	br
→
.	sp -1.1
.	in +150u
.	ps -1
\\$*
.	ps
.	in
..
.
.nr LEFT.ll \n[RESUME.split]u \" left side line length
.
.\" Begin the right side of the document
.de RIGHT
.	sp |\\n[TOP]u
.	po \\n[.o]u+\\n[.i]u+\\n[LEFT.ll]u+\\n[RESUME.gap]u
.	ll (\\n[RESUME.ll]u-\\n[.o]u)u
..
.\" Begin the left side of the document
.de LEFT
.	sp 2
.	ll \\n[LEFT.ll]u
.	mk TOP
..
.
.\" Print a grey line
.\"   Used for seperating elements using .blm LINE
.de LINE
.	sp -0.5
.	cl \*[RESUME.grey.cl]
.	in 0
\l'\\n[.l]u-'
.	in
.	cl
.	br
..
