//%attributes = {}
$files:=Folder:C1567(fk resources folder:K87:11).files(fk ignore invisible:K87:22)

$file:=$files[0]

$lines:=$file.getText("utf-8"; Document with CR:K24:21)

$comamnds:=New collection:C1472

For each ($line; Split string:C1554($lines; "\r"; sk ignore empty strings:K86:1))
	$command:="wkhtmltopdf --dpi 72 --image-dpi 300  --outline --user-style-sheet /Users/miyako/Desktop/print.css "
	$command:=$command+encode($line)
	$command:=$command+" --minimum-font-size 18 --disable-external-links --javascript-delay 3000 --print-media-type /Users/miyako/Desktop/"+Path to object:C1547(Split string:C1554($line; "/").pop()).name+".pdf"
	$comamnds.push($command)
End for each 

SET TEXT TO PASTEBOARD:C523($comamnds.join("\r"))
