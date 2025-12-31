property position : cs.LottieProperty
property size : cs.LottieProperty
property roundness : cs.LottieProperty

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.RECTANGLE)
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	This.position:=cs.LottieProperty.new(This; $const.PropertyType.POSITION)
	This.size:=cs.LottieProperty.new(This; $const.PropertyType.SIZE)
	This.roundness:=cs.LottieProperty.new(This; "rd")
	
	This.position.staticValue:=[0; 0]
	This.size.staticValue:=[100; 100]
	This.roundness.staticValue:=0

// Parse rectangle from JSON
Function fromJSON($json : Object) : cs.LottieRectangle
	
	Super.fromJSON($json)
	
	// Position (p)
	If ($json.p#Null)
		This.position.fromJSON($json.p)
	End if 
	
	// Size (s)
	If ($json.s#Null)
		This.size.fromJSON($json.s)
	End if 
	
	// Roundness (r)
	If ($json.r#Null)
		This.roundness.fromJSON($json.r)
	End if 
	
	return This

// Serialize rectangle to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.p:=This.position.toJSON()
	$json.s:=This.size.toJSON()
	$json.r:=This.roundness.toJSON()
	
	return $json
