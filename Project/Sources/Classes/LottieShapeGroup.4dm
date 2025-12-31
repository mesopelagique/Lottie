property shapes : Collection
property transform : cs.LottieTransform
property numProperties : Integer

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.GROUP)
	This.shapes:=[]
	This.transform:=cs.LottieTransform.new(This)

// Parse group from JSON
Function fromJSON($json : Object) : cs.LottieShapeGroup
	
	Super.fromJSON($json)
	
	// Number of properties (np)
	If ($json.np#Null)
		This.numProperties:=$json.np
	End if 
	
	// Items (it) - contains shapes and transform
	If ($json.it#Null)
		var $itemJson : Object
		For each ($itemJson; $json.it)
			// Check if this is a transform (ty = "tr")
			If ($itemJson.ty="tr")
				This.transform.fromJSON($itemJson)
			Else 
				var $shape : cs.LottieShape:=cs.LottieShape.new("").createFromJSON($itemJson; This)
				This.shapes.push($shape)
			End if 
		End for each 
	End if 
	
	return This

// Serialize group to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	If (This.numProperties#Null)
		$json.np:=This.numProperties
	End if 
	
	// Items array - shapes followed by transform
	$json.it:=[]
	
	var $shape : cs.LottieShape
	For each ($shape; This.shapes)
		$json.it.push($shape.toJSON())
	End for each 
	
	// Add transform as last item with type "tr"
	var $trJson : Object:=This.transform.toJSON()
	$trJson.ty:="tr"
	$json.it.push($trJson)
	
	return $json

// Get shapes by type within this group
Function getShapesByType($type : Text) : Collection
	
	var $result : Collection:=[]
	var $shape : cs.LottieShape
	For each ($shape; This.shapes)
		If ($shape.type=$type)
			$result.push($shape)
		End if 
	End for each 
	return $result
