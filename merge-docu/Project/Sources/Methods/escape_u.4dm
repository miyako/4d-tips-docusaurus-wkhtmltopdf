//%attributes = {}
C_TEXT:C284($1; $0; $escaped)

C_LONGINT:C283($i)
C_BOOLEAN:C305($shouldEscape)
C_BLOB:C604($data)

For ($i; 1; Length:C16($1))
	
	$char:=Substring:C12($1; $i; 1)
	$code:=Character code:C91($char)
	
	$shouldEscape:=False:C215
	
	Case of 
		: ($code=45)
		: ($code=46)
		: ($code>47) & ($code<58)
		: ($code>63) & ($code<91)
		: ($code=95)
		: ($code>96) & ($code<123)
		: ($code=126)
		Else 
			$shouldEscape:=True:C214
	End case 
	
	If ($shouldEscape)
		CONVERT FROM TEXT:C1011($char; "utf-8"; $data)
		For ($j; 0; BLOB size:C605($data)-1)
			$hex:=String:C10($data{$j}; "&x")
			$escaped:=$escaped+"%"+Substring:C12($hex; Length:C16($hex)-1)
		End for 
	Else 
		$escaped:=$escaped+$char
	End if 
	
End for 

$0:=$escaped