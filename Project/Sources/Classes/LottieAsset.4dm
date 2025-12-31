property id : Text
property _parent : Object

Class constructor
	
	This:C1470.id:=""
	
	// Factory: create asset from JSON
Function createFromJSON($json : Object; $parent : Object) : cs:C1710.LottieAsset
	
	var $asset : cs:C1710.LottieAsset
	
	// Check if precomp (has layers array)
	If ($json.layers#Null:C1517)
		$asset:=cs:C1710.LottiePrecompAsset.new()
	Else 
		// Image asset
		$asset:=cs:C1710.LottieImageAsset.new()
	End if 
	
	$asset._parent:=$parent
	$asset.fromJSON($json)
	
	return $asset
	
	// Parse base asset properties from JSON
Function fromJSON($json : Object) : cs:C1710.LottieAsset
	
	// ID (id)
	If ($json.id#Null:C1517)
		This:C1470.id:=$json.id
	End if 
	
	return This:C1470
	
	// Serialize base asset properties to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	$json.id:=This:C1470.id
	
	return $json
	