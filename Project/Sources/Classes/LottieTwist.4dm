property angle : cs.LottieProperty
property center : cs.LottieProperty

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.TWIST)
	
	This.angle:=cs.LottieProperty.new(This; "a")
	This.center:=cs.LottieProperty.new(This; "c")
	
	This.angle.staticValue:=0
	This.center.staticValue:=[0; 0]

// Parse twist from JSON
Function fromJSON($json : Object) : cs.LottieTwist
	
	Super.fromJSON($json)
	
	// Angle (a)
	If ($json.a#Null)
		This.angle.fromJSON($json.a)
	End if 
	
	// Center (c)
	If ($json.c#Null)
		This.center.fromJSON($json.c)
	End if 
	
	return This

// Serialize twist to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.a:=This.angle.toJSON()
	$json.c:=This.center.toJSON()
	
	return $json
