property fonts : Collection

Class constructor
	
	This.fonts:=[]

// Parse font list from JSON
Function fromJSON($json : Object) : cs.LottieFontList
	
	// List (list)
	If ($json.list#Null)
		var $fontJson : Object
		For each ($fontJson; $json.list)
			var $font : cs.LottieFont:=cs.LottieFont.new()
			$font.fromJSON($fontJson)
			This.fonts.push($font)
		End for each 
	End if 
	
	return This

// Serialize font list to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	If (This.fonts.length>0)
		$json.list:=[]
		var $font : cs.LottieFont
		For each ($font; This.fonts)
			$json.list.push($font.toJSON())
		End for each 
	End if 
	
	return $json

// Get font by name
Function getFontByName($name : Text) : cs.LottieFont
	
	var $font : cs.LottieFont
	For each ($font; This.fonts)
		If ($font.name=$name)
			return $font
		End if 
	End for each 
	return Null

// Get font by family
Function getFontByFamily($family : Text) : cs.LottieFont
	
	var $font : cs.LottieFont
	For each ($font; This.fonts)
		If ($font.family=$family)
			return $font
		End if 
	End for each 
	return Null

// Add font
Function addFont($name : Text; $family : Text; $style : Text) : cs.LottieFont
	
	var $font : cs.LottieFont:=cs.LottieFont.new()
	$font.name:=$name
	$font.family:=$family
	$font.style:=$style
	This.fonts.push($font)
	return $font
