property character : Text
property fontFamily : Text
property fontSize : Real
property fontStyle : Text
property width : Real
property data : Object

Class constructor
	
	This.character:=""
	This.fontFamily:=""
	This.fontSize:=0
	This.fontStyle:="Regular"
	This.width:=0

// Parse character from JSON
Function fromJSON($json : Object) : cs.LottieCharacter
	
	// Character (ch)
	If ($json.ch#Null)
		This.character:=$json.ch
	End if 
	
	// Font family (fFamily)
	If ($json.fFamily#Null)
		This.fontFamily:=$json.fFamily
	End if 
	
	// Font size (size)
	If ($json.size#Null)
		This.fontSize:=$json.size
	End if 
	
	// Font style (style)
	If ($json.style#Null)
		This.fontStyle:=$json.style
	End if 
	
	// Width (w)
	If ($json.w#Null)
		This.width:=$json.w
	End if 
	
	// Data (data) - contains shapes
	If ($json.data#Null)
		This.data:=$json.data
	End if 
	
	return This

// Serialize character to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	$json.ch:=This.character
	$json.fFamily:=This.fontFamily
	$json.size:=This.fontSize
	$json.style:=This.fontStyle
	$json.w:=This.width
	
	If (This.data#Null)
		$json.data:=This.data
	End if 
	
	return $json
