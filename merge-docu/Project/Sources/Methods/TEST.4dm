//%attributes = {}
$file:=Folder:C1567(fk resources folder:K87:11).file("v20_ja.txt")

$lines:=$file.getText("utf-8"; Document with CR:K24:21)

$URLs:=New collection:C1472
For each ($line; Split string:C1554($lines; "\r"; sk ignore empty strings:K86:1))
	//$line:=Replace string($line; "/Rx/ja/"; "/Rx/fr/"; *)
	$URLs.push($line)
End for each 

$HTML_folder:=Folder:C1567(fk desktop folder:K87:19).folder("HTML-JA")
$HTML_folder.create()

For each ($URL; $URLs)
	
	//If ($URL="@propertiesForm@")
	
	$name:=Path to object:C1547(Split string:C1554($URL; "/").pop()).name
	
	C_BLOB:C604($data)
	
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	
	If (HTTP Get:C1157($url; $data)=200)
		
		$html:=Convert to text:C1012($data; "utf-8")
		$html:=Replace string:C233($html; "<VariableName>"; "&lt;VariableName&gt;")
		$html:=Replace string:C233($html; "<FunctionName>"; "&lt;FunctionName&gt;")
		$html:=Replace string:C233($html; "<Static List>"; "&lt;Static List&gt;")
		$html:=Replace string:C233($html; "<username>"; "&lt;username&gt;")
		$html:=Replace string:C233($html; "<none>"; "&lt;none&gt;")
		
		CONVERT FROM TEXT:C1011($html; "utf-8"; $data)
		
		$options:=New object:C1471("xhtmlOut"; True:C214)
		$status:=Tidy($data; $options)
		
		If ($status.status=1)
			
			$html:=Replace string:C233($status.html; "&nbsp;"; "&#160;"; *)  //is this a Tidy bug?
			$html:=Replace string:C233($html; "<?[TableName]FieldName?>"; "&lt;?[TableName]FieldName&gt;")
			
			//SET TEXT TO PASTEBOARD($html)
			
			$dom:=DOM Parse XML variable:C720($html)
			XML SET OPTIONS:C1090($dom; XML indentation:K45:34; XML no indentation:K45:36)
			
			ARRAY TEXT:C222($nodes; 0)
			
			$node:=DOM Find XML element:C864($dom; "//script"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM REMOVE XML ELEMENT:C869($nodes{$i})
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//footer"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM REMOVE XML ELEMENT:C869($nodes{$i})
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//link[@href]"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM GET XML ATTRIBUTE BY NAME:C728($nodes{$i}; "href"; $href)
				If ($href="/docs@")
					DOM SET XML ATTRIBUTE:C866($nodes{$i}; "href"; "https://developer.4d.com"+$href)
				End if 
				If ($href="//@")
					DOM SET XML ATTRIBUTE:C866($nodes{$i}; "href"; "https:"+$href)
				End if 
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//*[@src]"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM GET XML ATTRIBUTE BY NAME:C728($nodes{$i}; "src"; $src)
				If ($src="/docs/@")
					DOM SET XML ATTRIBUTE:C866($nodes{$i}; "src"; "https://developer.4d.com"+$src)
				End if 
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//div[@class='fixedHeaderContainer']"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM REMOVE XML ELEMENT:C869($nodes{$i})
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//div[@class='docsNavContainer']"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM REMOVE XML ELEMENT:C869($nodes{$i})
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//div[@class='navPusher']"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM SET XML ATTRIBUTE:C866($nodes{$i}; "style"; "padding-top:0px!important;")
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//div[@class='mainContainer']"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM SET XML ATTRIBUTE:C866($nodes{$i}; "style"; "padding:50px 0 0 0!important;")
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//a[@id]"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM GET XML ATTRIBUTE BY NAME:C728($nodes{$i}; "id"; $id)
				If (Match regex:C1019(".*\\/(.+)"; $URL; 1; $pos; $len))
					$id:=Substring:C12($URL; $pos{1}; $len{1})+"_"+$id
				End if 
				DOM SET XML ATTRIBUTE:C866($nodes{$i}; "id"; escape_u($id))  //filename_anchor
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//h1[@class='postHeaderTitle']"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				//DOM SET XML ATTRIBUTE($nodes{$i}; "style"; "visibility:hidden;")
				$href:=$URL
				If (Match regex:C1019(".*\\/(.+)"; $href; 1; $pos; $len))
					$href:=Substring:C12($href; $pos{1}; $len{1})
				End if 
				$a:=DOM Create XML element:C865($nodes{$i}; "a"; "id"; escape_u($href); "class"; "anchor"; "aria-hidden"; "true")
			End for 
			
			$node:=DOM Find XML element:C864($dom; "//a[@href]"; $nodes)
			For ($i; 1; Size of array:C274($nodes))
				DOM GET XML ATTRIBUTE BY NAME:C728($nodes{$i}; "href"; $href)
				If (Match regex:C1019("#(.+)"; $href; 1; $pos; $len))
					$id:=Substring:C12($href; $pos{1}; $len{1})
					If (Match regex:C1019(".*\\/(.+)"; $URL; 1; $pos; $len))
						$href:=Substring:C12($URL; $pos{1}; $len{1})+"_"+$id
					End if 
					DOM SET XML ATTRIBUTE:C866($nodes{$i}; "href"; "#"+escape_u($href))
				Else 
					
					If (Match regex:C1019("\\/docs\\/.+\\/(.+)"; $href; 1; $pos; $len))
						$href:=Substring:C12($href; $pos{1}; $len{1})
						If (Match regex:C1019("#(.+)"; $href; 1; $pos; $len))
							DOM SET XML ATTRIBUTE:C866($nodes{$i}; "href"; "./"+escape_u($href))
						Else 
							//local
							DOM SET XML ATTRIBUTE:C866($nodes{$i}; "href"; "#"+escape_u($href))
						End if 
					End if 
					
				End if 
				
			End for 
			
			DOM EXPORT TO VAR:C863($dom; $data)
			DOM CLOSE XML:C722($dom)
			
			$options:=New object:C1471("xhtmlOut"; True:C214)
			$status:=Tidy($data; $options)
			
			$HTML_folder.file($name+".html").setText(TEST_h1($status.html))
			
		Else 
			
			TRACE:C157
			
		End if 
		
	Else 
		
		TRACE:C157
		
	End if 
	
	//End if 
	
End for each 