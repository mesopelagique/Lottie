property name : Text
property family : Text
property style : Text
property ascent : Real
property origin : Integer
property path : Text

Class constructor
	
	This.name:=""
	This.family:=""
	This.style:="Regular"
	This.ascent:=0
	This.origin:=0
	This.path:=""

// Parse font from JSON
Function fromJSON($json : Object) : cs.LottieFont
	
	// Font name (fName)
	If ($json.fName#Null)
		This.name:=$json.fName
	End if 
	
	// Font family (fFamily)
	If ($json.fFamily#Null)
		This.family:=$json.fFamily
	End if 
	
	// Font style (fStyle)
	If ($json.fStyle#Null)
		This.style:=$json.fStyle
	End if 
	
	// Ascent (ascent)
	If ($json.ascent#Null)
		This.ascent:=$json.ascent
	End if 
	
	// Origin (origin)
	If ($json.origin#Null)
		This.origin:=$json.origin
	End if 
	
	// Path (fPath)
	If ($json.fPath#Null)
		This.path:=$json.fPath
	End if 
	
	return This

// Serialize font to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	$json.fName:=This.name
	$json.fFamily:=This.family
	$json.fStyle:=This.style
	
	If (This.ascent#0)
		$json.ascent:=This.ascent
	End if 
	
	If (This.origin#0)
		$json.origin:=This.origin
	End if 
	
	If (This.path#"")
		$json.fPath:=This.path
	End if 
	
	return $json
