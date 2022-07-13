//%attributes = {}
$command:="wkhtmltopdf --dpi 72 --image-dpi 300  --outline --user-style-sheet /Users/miyako/Desktop/print.css "

//SET TEXT TO PASTEBOARD($command)

$PDF_folder:=Folder:C1567(fk desktop folder:K87:19).folder("PDF")
$PDF_folder.create()

$command:=" --minimum-font-size 14 --javascript-delay 3000 --print-media-type "+$PDF_folder.file("v19_R5-ES.pdf").path

SET TEXT TO PASTEBOARD:C523($command)