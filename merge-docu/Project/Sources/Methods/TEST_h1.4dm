//%attributes = {"invisible":true}
#DECLARE($in : Text)->$out : Text

$html:=$in

ARRAY LONGINT:C221($pos; 0)
ARRAY LONGINT:C221($len; 0)

If (Match regex:C1019("(?sm)(<h1 [^>]+>)\\s*(.+?)(<a.+?)</h1>"; $html; 1; $pos; $len))
	
	$code:=Substring:C12($html; $pos{2}; $len{2})
	
	$before:=Substring:C12($html; 1; $pos{1}+$len{1}-1)
	
	$after:=Substring:C12($html; $pos{3}+$len{3}; Length:C16($html))
	
	$out:=$before+$code+$after
	
Else 
	
	$out:=$in
	
End if 

//If (Match regex("(?sm)(<header [^>]+>)"; $html; 1; $pos; $len))

//$code:=Substring($html; $pos{2}; $len{2})

//$before:=Substring($html; 1; $pos{1}+$len{1}-1)

//$after:=Substring($html; $pos{3}+$len{3}; Length($html))

//$out:=$before+$code+$after

//Else 

//$out:=$in

//End if 