//%attributes = {}
$file:=Folder:C1567(fk resources folder:K87:11).file("Rx_ja.txt")

$lines:=$file.getText("utf-8"; Document with CR:K24:21)

$URLs:=New collection:C1472
For each ($line; Split string:C1554($lines; "\r"; sk ignore empty strings:K86:1))
	//$line:=Replace string($line; "/Rx/ja/"; "/Rx/en/"; *)
	$URLs.push($line)
End for each 

$command:="wkhtmltopdf --dpi 72 --image-dpi 300  --outline --user-style-sheet /Users/miyako/Desktop/print.css "

For each ($URL; $URLs.slice(0; 10))
	
	$command:=$command+$URL+" "
	
End for each 

$PDF_folder:=Folder:C1567(fk desktop folder:K87:19).folder("PDF")
$PDF_folder.create()

$command:=$command+" --minimum-font-size 18 --javascript-delay 3000 --print-media-type "+$PDF_folder.file("v19_R5-JA.pdf").path

SET TEXT TO PASTEBOARD:C523($command)