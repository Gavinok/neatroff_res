\" .ds fp.src /home/gavinok/neatroff_make_1/res
\" .ds fp.mkfn /home/gavinok/neatroff_make_1/neatmkfn/mkfn
\" .fp.ttf - FB fa-brands-400
.ll \n[.l]u+300u
.nr RESUME.margin 1c
.po -230u
.
.nr TITLE.ps 25
.nr HEADING.ps 15
.
.\" what color are headers and extra markings
.ds RESUME.cl #009688
.ds RESUME.grey.cl #dddddd
.
.\" How big is the gap between columns
.nr RESUME.gap (1.3c)u
.
.\" Where does the first column end?
.
.nr RESUME.ll \n[.l] \"total line length
.nr RESUME.split 3.4i
.
.nr RESUME.po \n[.o] \"original page offset
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
.nr TITLE.wid \w'\\$*'
.mk TITLE
\\$*
.	ft
.	ps
.	br
..
.
.\" Description of yourself
.\" DESC Mother Fucking Boss
.de DESC.doter
.	if \\n[DESC.num]>0 \{\
.	nr DESC.num -1
\m[]\(ci\m[]
.	\}
..
.de DESC
.	ad l
.	cl \\*[RESUME.cl]
.	ft TITLE
.	if !'\\*[email]'' \{\
\\*[post.url mailto:\\*[email] "\\*[email]"]
.	nr DESC.num +1
.	\}
.	if !'\\*[phone]'' \{\
.	DESC.doter
\\*[phone]
.	nr DESC.num +1
.	\}
.	if !'\\*[github]'' \{\
.	DESC.doter
\\*[post.url http://github.com/\\*[github] "\f(FB\fP \\*[github]"]
.	nr DESC.num +1
.\}
.\" .	if !'\\*[youtube]''\{\
.\" .	DESC.doter
.\" \\*[post.url \\*[youtube.url] "\\*[youtube]"]
.\" .	nr DESC.num +1
.\" .\}
.	ft
.	cl
.br
.ad b
..
.
.\" Heading for a section
.\" HEADING LIFE PHILOSOPY
.de HEADING
.	sp
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
.de SUBHEADING
.	br
.	ft B
\\$*
.\" use remaining line length for right side
.	ft
.	br
..
.de →
.	br
→
.	sp -1.0
.	in +150u
.	ps -1
\\$*
.	ps
.	in
.	sp \\n[→.sp]u
..
.
.\" Begin the left side of the document
.de LEFT
.	ll \\n[RESUME.split]u
.	mk TOP
..
.\" Begin the right side of the document
.de RIGHT
.	sp |\\n[TOP]u
.	nr ll+gap (\\n[RESUME.split]u+\\n[RESUME.gap]u)u
.	po \\n[.o]u+\\n[.i]u+\\n[ll+gap]u
.	ll \\n[RESUME.ll]u-\\n[ll+gap]u
..
.de FULL
.	br
.	ll \\n[RESUME.ll]u
.	po \\n[RESUME.po]u
..
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
.\" .EXP COMPANY_OR_TOPIC LOCATION TITLE DATES
.de EXP
.mk TMP
.	ft B
\\$1
.	ft
.	br
.	if !'\\$2''\{\
.		sp |\\n[TMP]u
.		ad r
\\$2
.		br
.		mk TMP
.	\}
.	ft I
.	if !'\\$3''\{\
.		ad l
\\$3
.		br
.	\}
.	ie !'\\$4''\{\
.		ad r
.		sp |\\n[TMP]u
\\$4
.		ft
.	\}
.	br
.	ad l
.	sp \\n[EXP.sp]u
..
