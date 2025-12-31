property mergeMode : Integer

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.MERGE)
	This.mergeMode:=1

// Parse merge from JSON
Function fromJSON($json : Object) : cs.LottieMerge
	
	Super.fromJSON($json)
	
	// Merge mode (mm)
	If ($json.mm#Null)
		This.mergeMode:=$json.mm
	End if 
	
	return This

// Serialize merge to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.mm:=This.mergeMode
	
	return $json
