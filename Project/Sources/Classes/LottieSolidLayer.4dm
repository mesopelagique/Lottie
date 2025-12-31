property color : Text
property solidWidth : Integer
property solidHeight : Integer

Class extends LottieLayer

Class constructor
	
	Super(cs.LottieConstants.me.LayerType.SOLID)
	This.color:="#000000"
	This.solidWidth:=0
	This.solidHeight:=0

// Parse solid layer from JSON
Function fromJSON($json : Object) : cs.LottieSolidLayer
	
	// Parse base layer properties
	Super.fromJSON($json)
	
	// Solid color (sc)
	If ($json.sc#Null)
		This.color:=$json.sc
	End if 
	
	// Solid width (sw)
	If ($json.sw#Null)
		This.solidWidth:=$json.sw
	End if 
	
	// Solid height (sh)
	If ($json.sh#Null)
		This.solidHeight:=$json.sh
	End if 
	
	return This

// Serialize solid layer to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.sc:=This.color
	$json.sw:=This.solidWidth
	$json.sh:=This.solidHeight
	
	return $json

// Get color as RGB collection [r, g, b] (0-255)
Function get colorRGB() : Collection
	
	var $hex : Text:=This.color
	
	// Remove # if present
	If ($hex[[1]]="#")
		$hex:=Substring($hex; 2)
	End if 
	
	If (Length($hex)>=6)
		var $r : Integer:=This._hexToInt(Substring($hex; 1; 2))
		var $g : Integer:=This._hexToInt(Substring($hex; 3; 2))
		var $b : Integer:=This._hexToInt(Substring($hex; 5; 2))
		return [$r; $g; $b]
	End if 
	
	return [0; 0; 0]

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

// Set color from RGB values (0-255)
Function setColorRGB($r : Integer; $g : Integer; $b : Integer)
	
	This.color:="#"+This._intToHex($r)+This._intToHex($g)+This._intToHex($b)

// Convert integer to 2-digit hex string
Function _intToHex($val : Integer) : Text
	
	var $hex : Text:="0123456789ABCDEF"
	var $high : Integer:=$val >> 4
	var $low : Integer:=$val & 15
	return $hex[[$high+1]]+$hex[[$low+1]]
