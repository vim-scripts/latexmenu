"=============================================================================
" 	     File: latexmenu.vim
"      Author: Philipp Braunbarth
"       Email: blub@immortux.de
"     Created: 18.Feb 2005
"     Version: 0.1
" 
"  Description: Navigationmenu for .tex Files
"  Licence: GPL
"=============================================================================

"function GenerateLatexMenu_plain()
"	call GenerateLatexMenu('plain')
"endfunction 

"function GenerateLatexMenu_tree()
"	call GenerateLatexMenu('tree')
"endfunction 



function GenerateLatexMenu()

 an Na&vigation.dummy <Nop>
 aunmenu Na&vigation
 an Na&vigation.Refresh :call GenerateLatexMenu()<CR>
 an Na&vigation.-sep1-	<Nop>
 

 let l:originline = line(".")
 let l:origincol  = col(".")
 call cursor(1,1)

 

 let l:exprP = '.*\c\\part{'
 let l:exprC = '.*\c\\chapter{'
 let l:exprS = '.*\c\\section{'
 let l:exprSS = '.*\c\\subsection{'
 let l:exprSSS = '.*\c\\subsubsection{'
 let l:exprAa = '\cbegin{appendix}'
 let l:exprAb =  '\c\\appendix'
 let l:chapcount = 1
 let l:seccount = 1
 let l:sseccount = 1
 let l:ssseccount = 1
 let l:sep = 2
 let l:appendix=0

 let l:lastline = line("$")
 let l:n = 1
 
 if search(l:exprC,"W") > 0
   while l:n < l:lastline
 	execute "let l:exec = \":call Jumpto(".l:n.")<CR>\""  
 	let buffer = getline(l:n)	
	if match(buffer,l:exprAa) != -1 || match(buffer,l:exprAb) != -1
		execute "an Na&vigation.-sep".l:sep."-	<Nop>"
		let l:sep = l:sep + 1
		let l:appendix=1
		let chapcount = 1
		"execute "an " "Navigation." . l:name . " " . exec
	end
	if l:appendix == 1
		if l:chapcount == 1
			let l:cchapter = Appendix(l:chapcount)
		else
			let l:cchapter = Appendix(l:chapcount - 1)
		endif
		let l:dchapter = Appendix(l:chapcount)
	else
		let l:cchapter = l:chapcount - 1
		let l:dchapter = l:chapcount
	endif
	if match(buffer,l:exprP) != -1
		execute "an Na&vigation.-sep".l:sep."-	<Nop>"
		let l:sep = l:sep + 1
		let l:tmp = substitute(buffer,l:exprP,"","")
		let l:name = ConvertString(l:tmp)
		execute "an " "Navigation." . l:name . " " . exec
	end
	if match(buffer,l:exprC) != -1
		execute "an Na&vigation.-sep".l:sep."-	<Nop>"
		let l:sep = l:sep + 1
		let l:tmp = substitute(buffer,l:exprC,"","")
		let l:name = ConvertString(l:tmp)
		execute "an " "Navigation."."&" . l:dchapter . '\ \ \ \ \ \ \ \ ' . l:name . " " . l:exec
		let l:chapcount = l:chapcount+1
		let l:seccount = 1
		let l:sseccount = 1
		let l:ssseccount = 1
	end
	if match(buffer,l:exprS) != -1
		let l:tmp = substitute(buffer,l:exprS,"","")
		let l:name = ConvertString(l:tmp)
		"let l:cchapter = l:chapcount - 1
		execute "an " "Navigation." . l:cchapter.'\.'. l:seccount . '\ \ \ \ \ \ ' . l:name	. " ". l:exec
		let l:seccount = l:seccount+1
		let l:sseccount = 1
		let l:ssseccount = 1
	end
	if match(buffer,l:exprSS) != -1
		let l:tmp = substitute(buffer,l:exprSS,"","")
		let l:name = ConvertString(l:tmp)
		"let l:cchapter = l:chapcount - 1
		let l:csection = l:seccount - 1
		execute "an " "Navigation." . l:cchapter.'\.'.l:csection.'\.'. l:sseccount . '\ \ \ \ ' . l:name . " " . l:exec
		let l:sseccount = l:sseccount+1
		let l:ssseccount = 1
	end
	if match(buffer,l:exprSSS) != -1
		let l:tmp = substitute(buffer,l:exprSSS,"","")
		let l:name = ConvertString(l:tmp)
		"let l:cchapter = l:chapcount - 1
		let l:csection = l:seccount - 1
		let l:cssection = l:sseccount - 1
		execute "an " "Navigation." . l:cchapter.'\.'.l:csection.'\.'.l:cssection.'\.'.l:ssseccount . '\ \ ' . l:name . " " . l:exec
		let l:ssseccount = l:ssseccount+1
	end
	let l:n = l:n + 1
   endwhile
 else
   while n < l:lastline
 	execute "let l:exec = \":call Jumpto(".l:n.")<CR>\""  
 	let buffer = getline(l:n)
	if match(buffer,l:exprAa) != -1 || match(buffer,l:exprAb) != -1
		execute "an Na&vigation.-sep".l:sep."-	<Nop>"
		let l:sep = l:sep + 1
		let l:appendix=1
		let seccount = 1
		"execute "an " "Navigation." . l:name . " " . exec
	end
	if l:appendix == 1
		if l:seccount == 1
			let l:csection = Appendix(l:seccount)
		else
			let l:csection = Appendix(l:seccount - 1)
		endif
		let l:dsection = Appendix(l:seccount)
	else
		let l:csection = l:seccount - 1
		let l:dsection = l:seccount
	endif
	if match(buffer,l:exprP) != -1
		execute "an Na&vigation.-sep".l:sep."-	<Nop>"
		let l:sep = l:sep + 1
		let l:tmp = substitute(buffer,l:exprP,"","")
		let l:name = ConvertString(l:tmp)
		execute "an " "Navigation." . l:name . " " . l:exec
	end
	if match(buffer,l:exprS) != -1
		execute "an Na&vigation.-sep".l:sep."-	<Nop>"
		let l:sep = l:sep + 1
		let l:tmp = substitute(buffer,l:exprS,"","")
		let l:name = ConvertString(l:tmp)
		execute "an " "Navigation." ."&". l:dsection . '\ \ \ \ \ \ ' . l:name	. " ". l:exec
		let l:seccount = l:seccount+1
		let l:sseccount = 1
		let l:ssseccount = 1
	end
	if match(buffer,l:exprSS) != -1
		let l:tmp = substitute(buffer,l:exprSS,"","")
		let l:name = ConvertString(l:tmp)
		"let l:csection = l:seccount - 1
		execute "an " "Navigation." . l:csection.'\.'. l:sseccount . '\ \ \ \ ' . l:name . " " . l:exec
		let l:sseccount = l:sseccount+1
		let l:ssseccount = 1
	end
	if match(buffer,l:exprSSS) != -1
		let l:tmp = substitute(buffer,l:exprSSS,"","")
		let l:name = ConvertString(l:tmp)
		"let l:csection = l:seccount - 1
		let l:cssection = l:sseccount - 1
		execute "an " "Navigation." . l:csection.'\.'.l:cssection.'\.'.l:ssseccount . '\ \ ' . l:name . " " . l:exec
		let l:ssseccount = l:ssseccount+1
	end
	let l:n = l:n + 1
   endwhile
 endif  
 call cursor(l:originline,l:origincol)
endfunction

function Jumpto(line)
	call cursor(a:line,1)
	let l:i = 1
	while l:i < 100
		normal zo
		let l:i = l:i + 1
	endwhile
endfunction

function ConvertString(line)
	let l:tmp = a:line
	let l:tmp = substitute(l:tmp,'\M\\\clatex{}',"LaTeX","g")
	let l:tmp = substitute(l:tmp,'\M\\\ctex{}',"TeX","g")
	let l:tmp = substitute(l:tmp,'\M\\\clyx{}',"LyX","g")
	let l:tmp = substitute(l:tmp,'\M\\index{\.\{-\}}',"","g")
	let l:tmp = substitute(l:tmp,'\M\\label{\.\{-\}}',"","g")
	let l:tmp = substitute(l:tmp,'\M\\footnote{\.\{-\}}',"","g")
	let l:tmp = substitute(l:tmp,'\M\\ref{\.\{-\}}',"","g")
	let l:tmp = substitute(l:tmp,'\M\\\.\{-\}{',"","g")
	let l:tmp = substitute(l:tmp,"[\$|\{|\}|\\[|\\]|\&]","","g")
	let l:tmp = substitute(l:tmp," ",'\\ ',"g")
	let l:name = substitute(l:tmp,"\\.",'\\.',"g")
	return l:name
endfunction

function Appendix(n)
	let l:result = strpart('XABCDEFGHIJKLMNOPQRSTUVWXYZ',a:n,'1')
	return l:result
endfunction

