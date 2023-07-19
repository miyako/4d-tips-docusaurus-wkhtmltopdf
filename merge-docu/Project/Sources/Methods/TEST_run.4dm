//%attributes = {}
$command:="wkhtmltopdf --dpi 72 --image-dpi 300  --outline --outline-depth 2 --user-style-sheet /Users/miyako/Desktop/print.css "

//SET TEXT TO PASTEBOARD($command)

$PDF_folder:=Folder:C1567(fk desktop folder:K87:19).folder("PDF")
$PDF_folder.create()

$command:=" --minimum-font-size 18 --javascript-delay 3000 --print-media-type "+$PDF_folder.file("v19_R5-FR.pdf").path

SET TEXT TO PASTEBOARD:C523($command)