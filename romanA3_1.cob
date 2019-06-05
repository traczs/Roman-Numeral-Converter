identification division.
program-id. romannumerals.
environment division.
input-output section.
file-control.
    select standard-input assign to keyboard.
    select standard-output assign to display.
    select ifile assign to dynamic ws-fname
		organization is line sequential.

data division.
file section.
fd standard-input.
    01 stdin-record   pic x(80).
fd standard-output.
    01 stdout-record  pic x(80).
fd ifile.
01 input-record.
	05 roman-numeral pic x(10).
working-storage section.
77 eof-switch pic 9 value 1.
77  i pic 9.
77  ws-fname pic x(30).
77  trailing-spaces     pic s99 usage is computational.
77  str-len    pic s99 usage is computational.
77  n    pic s99 usage is computational.
77  temp pic s9(8) usage is computational.
77  ret  pic s9 usage is computational-3.
01  array-area.
    02 r pic x(1) occurs 30 times.
01  input-area.
    02 in-r   pic x(30).
    02 filler pic x(79).
01  title-line.
    02 filler pic x(11) value spaces.
    02 filler pic x(24) value 'roman number equivalents'.
01  underline-1.
    02 filler pic x(45) value 
       ' --------------------------------------------'.
01  col-heads.
    02 filler pic x(9) value spaces.
    02 filler pic x(12) value 'roman number'.
    02 filler pic x(13) value spaces.
    02 filler pic x(11) value 'dec. equiv.'.
01  underline-2.
    02 filler pic x(45) value
       ' ------------------------------   -----------'.
01  print-line.
    02 filler pic x value space.
    02 out-r  pic x(30).
    02 filler pic x(3) value spaces.
    02 out-eq pic z(9).

procedure division.
    open input standard-input, output standard-output.
*>prompt user for file input or keyboard choice
perform userprompt until in-r equals "q".
userprompt. 
    display "keyboard(k) or file(f) or quit(q)?".
    read standard-input into input-area.
    evaluate in-r 
		when "k" perform keyboard
		when "f" perform userfile
		when "q" display "press enter to exit program".
end-userprompt.
	stop run.
    
*>performs the paragraph when user uses keyboard
keyboard.   
	write stdout-record from title-line after advancing 0 lines.
    write stdout-record from underline-1 after advancing 1 line.
    write stdout-record from col-heads after advancing 1 line.
    write stdout-record from underline-2 after advancing 1 line.
    display " ".
    display "Enter roman numerals, press q and press enter twice to quit".
*> spaghett is the loop that keeps on prompting for roman numerals
perform spaghett until array-area equals "q".
spaghett.
	display " ".
	
	move 1 to n. move spaces to array-area.
	read standard-input into input-area.
    *> calculates the length of the input
    move zero to trailing-spaces.                                     
    inspect function reverse (in-r)  
        tallying 
        trailing-spaces for leading space.                                    
    compute str-len = length of in-r - trailing-spaces.
    move in-r to array-area.
    *> calls on the conv.cob file 
    call "conv" using array-area, str-len, ret, temp.
    *> the roman numerals will only be calculated if valid
    if ret equals 1
    then
		move temp to out-eq move array-area to out-r
		write stdout-record from print-line after advancing 1 line
	end-if.
    
    display " ".
end-spaghett.
	perform userprompt.
end-keyboard.
*> userfile is the paragraph that executes when user wants to parse a file
userfile.
*> prompting for a file name and then taking that info
	display "enter file name".
	accept ws-fname.
	display" ".
	open input ifile.
		perform filecalc
			until eof-switch = 0.
	close ifile.
	
	
		
end-userfile.

*> performs all the same things as the keyboard way, but for each line in the file
filecalc.
	read ifile into roman-numeral
		at end move zero to eof-switch
	end-read.
	if eof-switch is not equal to zero
	*> calculates theh length of the input 
		move zero to trailing-spaces.                                     
		inspect function reverse (roman-numeral)  
			tallying 
			trailing-spaces for leading space.                                    
		compute str-len = length of roman-numeral - trailing-spaces.
		move roman-numeral to array-area.
		*>calls on the conv.cob file
		call "conv" using array-area, str-len, ret, temp.
		*> only displays calculation if valid roman numeral
		if ret equals 1
		then
			move temp to out-eq move array-area to out-r
			write stdout-record from print-line after advancing 1 line
		end-if.

end-filecalc.
    close standard-input, standard-output. 
    
