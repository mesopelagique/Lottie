property color : cs.LottieProperty
property opacity : cs.LottieProperty
property fillRule : Integer

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.FILL)
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	This.color:=cs.LottieProperty.new(This; $const.PropertyType.COLOR)
	This.opacity:=cs.LottieProperty.new(This; $const.PropertyType.OPACITY)
	This.fillRule:=$const.FillRule.NON_ZERO
	
	This.color.staticValue:=[1; 0; 0]  // Red default
	This.opacity.staticValue:=100

// Parse fill from JSON
Function fromJSON($json : Object) : cs.LottieFill
	
	Super.fromJSON($json)
	
	// Color (c)
	If ($json.c#Null)
		This.color.fromJSON($json.c)
	End if 
	
	// Opacity (o)
	If ($json.o#Null)
		This.opacity.fromJSON($json.o)
	End if 
	
	// Fill rule (r)
	If ($json.r#Null)
		This.fillRule:=$json.r
	End if 
	
	return This

// Serialize fill to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.c:=This.color.toJSON()
	$json.o:=This.opacity.toJSON()
	$json.r:=This.fillRule
	
	return $json

// Get color at frame as [r, g, b] (0-1 range)
Function getColor($frame : Real) : Collection
	
	return This.color.getValue($frame)

// Get color as hex string at frame
Function getColorHex($frame : Real) : Text
	
	var $rgb : Collection:=This.getColor($frame)
	If ($rgb=Null) | ($rgb.length<3)
		return "#000000"
	End if 
	
	var $r : Integer:=Round($rgb[0]*255; 0)
	var $g : Integer:=Round($rgb[1]*255; 0)
	var $b : Integer:=Round($rgb[2]*255; 0)
	
	return "#"+This._intToHex($r)+This._intToHex($g)+This._intToHex($b)

// Convert integer to 2-digit hex string
Function _intToHex($val : Integer) : Text
	
	var $hex : Text:="0123456789ABCDEF"
	var $high : Integer:=$val >> 4
	var $low : Integer:=$val & 15
	return $hex[[$high+1]]+$hex[[$low+1]]

// Set color from hex string
Function setColorHex($hex : Text)
	
	// Remove # if present
	If ($hex[[1]]="#")
		$hex:=Substring($hex; 2)
	End if 
	
	If (Length($hex)>=6)
		var $r : Real:=This._hexToInt(Substring($hex; 1; 2))/255
		var $g : Real:=This._hexToInt(Substring($hex; 3; 2))/255
		var $b : Real:=This._hexToInt(Substring($hex; 5; 2))/255
		This.color.staticValue:=[$r; $g; $b]
	End if 

// Convert hex string to integer
Function _hexToInt($hex : Text) : Integer
	
	var $result : Integer:=0
	var $i : Integer
	var $char : Text
	var $val : Integer
	
	$hex:=Uppercase($hex)
	
	For ($i; 1; Length($hex))
		$char:=$hex[[$i]]
		Case of 
			: ($char>="0") & ($char<="9")
				$val:=Character code($char)-Character code("0")
			: ($char>="A") & ($char<="F")
				$val:=10+(Character code($char)-Character code("A"))
			Else 
				$val:=0
		End case 
		$result:=($result*16)+$val
	End for 
	
	return $result
