#############################################################################
# THIS IS JUST AN *EXAMPLE* CONFIG FILE
#
# Feel free to get inspired, use all examples on your own risk!
#
&nbsp;
# To hide the SEARCH lines from the log, uncomment this:
#showlog: -search
&nbsp;
##############################################################################
# Shut off SMS during work-hours
#
whennot: wday 1-5 hour 0900-1800 # working time
when: month 12 day 24-27 # x-mas
when: month 12 day 31    # new year
when: month 1 day 1-6    # new year
when: month 5 day 1      # 1 May
begin
  # accept
else
  break
end
&nbsp;
#############################################################################
# Create a file conditionally on the presense of a good subject
#
options: subject prio 1
if: "enable mail2sms please"
  create: .mail2sms.on
  delete: .mail2sms.off
endif
&nbsp;
#############################################################################
# Allow a file presense to override the previous decision
#
when: file .mail2sms.on
begin
  unbreak
end
&nbsp;
#############################################################################
# Ignore mails with "no sms" in subject
#
options: subject
if: "no sms"
  abort: no sms requested
endif
&nbsp;
&nbsp;
##############################################################################
# First-line stuff in replies:
#
options: once body # a few options please
log: On-wrote junk
search: "^(On .* wrote:)"
replace:
&nbsp;
##############################################################################
# Quoted lines:
#
options: body prio 2
search: ^ *&gt;.*
log: quote-removal
replace:
&nbsp;
##############################################################################
# Initial spaces
#
options: fullbody prio 2 subject
search: "^ +"
log: spaces in the beginning of lines
replace:
&nbsp;
##############################################################################
# "re:" parts in subjects
#
options: subject nocase
search: .*(Re|Ang|Sv)(\[.*\]|): *
log: re/ang/sv-stuff in subject lines
replace:
&nbsp;
##############################################################################
# Sequences of weird letters only one of them
#
options: fullbody prio 4
search: "([-\.=!+*#;:,~!&]){2,}"
log: multiple weirdo letters
replace: \1
&nbsp;
##############################################################################
# Remove space between certain punctuation letters.
#
options: fullbody prio 4
log: non-alnum, space, non-alnum =&gt; remove space
search: "([-*!=.,]) ([-*!=.,])"
replace: \1\2
&nbsp;
##############################################################################
# Remove space after non-word symbols
#
log: Remove spaces after symbols
options: prio 4
search: "(\W) +"
replace: \1
&nbsp;
##############################################################################
# Cut off parentheses from From names.
#
options: from
log: cut off parantheses junk
search: \([^)]*\)
replace:
&nbsp;
##############################################################################
# Cut off known domain names from email addresses
#
log: cut off @*.frontec.se and @frontec-uk.com domains
search: @(....|)frontec(-uk|).(se|com)
replace: ""
&nbsp;
##############################################################################
# URLs don't do any good in SMS messages:
#
options: nocase
log: remove http/ftp-URL
search: (http|ftp)://[a-z0-9.~/-]*
replace: (URL)
&nbsp;
##############################################################################
# Make friends' names appear in shorter versions:
#
&nbsp;
options: nocase
log: Daniel=&gt;dast
search: "Daniel.Stenberg"
replace: DaSt
&nbsp;
##############################################################################
# Output with two extra spaces:
#
output: "F:$from S:$subject B:$body"
&nbsp;
#############################################################################
# Different output depending on sender
#
options: toaddress nocase
if: "coala@example.es"
  output: "CoALA F:$from S:$subject B:$body"
endif
options: toaddress nocase
if: "coala@example.com"
  output: "CoALA ES F:$from S:$subject B:$body"
endif
