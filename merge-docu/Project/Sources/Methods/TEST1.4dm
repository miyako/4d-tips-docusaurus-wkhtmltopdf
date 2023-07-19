//%attributes = {}
$file:=Folder:C1567(fk resources folder:K87:11).file("v20_ja.txt")

$lines:=$file.getText("utf-8"; Document with CR:K24:21)

$URLs:=New collection:C1472
For each ($line; Split string:C1554($lines; "\r"; sk ignore empty strings:K86:1))
	$URLs.push($line)
End for each 

$names:=New collection:C1472

For each ($URL; $URLs)
	$name:=Path to object:C1547(Split string:C1554($URL; "/").pop()).name
	$names.push($name+".html")
End for each 

SET TEXT TO PASTEBOARD:C523($names.join(" "))

