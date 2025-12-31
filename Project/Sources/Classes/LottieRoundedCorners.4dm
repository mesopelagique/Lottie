property radius : cs.LottieProperty

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.ROUNDED_CORNERS)
	
	This.radius:=cs.LottieProperty.new(This; "r")
	This.radius.staticValue:=10

// Parse rounded corners from JSON
Function fromJSON($json : Object) : cs.LottieRoundedCorners
	
	Super.fromJSON($json)
	
	// Radius (r)
	If ($json.r#Null)
		This.radius.fromJSON($json.r)
	End if 
	
	return This

// Serialize rounded corners to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.r:=This.radius.toJSON()
	
	return $json
