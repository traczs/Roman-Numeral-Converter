identification division.
program-id. conv.
environment division.
input-output section.
file-control.
    select standard-output assign to display.

data division.
file section.
fd standard-output.
    01 stdout-record  pic x(80).

working-storage section.
77  i    pic s99 usage is computational.
77  prev pic s9(8) usage is computational.
77  d    pic s9(4) usage is computational.
01 error-mess.
    02 filler pic x(22) value ' illegal roman numeral'.

linkage section.
77  m    pic s99 usage is computational.
77  err  pic s9 usage is computational-3.
77  sum1 pic s9(8) usage is computational.
01  array-area.
    02 s pic x(1) occurs 30 times.

procedure division using array-area, m, err, sum1.
    move zero to sum1. move 1001 to prev.
    perform loop thru end-loop varying i from 1 by 1
       until i is greater than m.
    move 1 to err. goback.
loop.
*>checks for upper case roman numerals
    move 0 to d.
    if s(i) is equal to 'I'
    then 
		move 1 to d
	end-if.
    if s(i) is equal to 'V'
    then
		move 5 to d
	end-if.
    if s(i) is equal to 'X'
    then
		move 10 to d
	end-if.
    if s(i) is equal to 'L'
    then
		move 50 to d
	end-if.
    if s(i) is equal to 'C'
    then 
		move 100 to d
	end-if.
    if s(i) is equal to 'D'
    then
		move 500 to d
	end-if.
    if s(i) is equal to 'M'
    then
		move 1000 to d
	end-if.
	*> checks for lower case roman numerals
    if s(i) is equal to 'i'
    then 
		move 1 to d
	end-if.
    if s(i) is equal to 'v'
    then 
		move 5 to d
	end-if.
    if s(i) is equal to 'x'
    then 
		move 10 to d
	end-if.
	if s(i) is equal to 'l'
	then
		move 50 to d
	end-if.
    if s(i) is equal to 'c'
    then
		move 100 to d
	end-if.
    if s(i) is equal to 'd'
    then
		move 500 to d
	end-if.
    if s(i) is equal to 'm'
    then
		move 1000 to d
	end-if.
	if d is equal to 0
	then
		open output standard-output
		write stdout-record from error-mess after advancing 1 line
		move 2 to err
		close standard-output
		goback.
    add d to sum1.
    if d is greater than prev
       compute sum1 = sum1 - 2 * prev.
end-loop. move d to prev. 
