property position : cs.LottieProperty
property size : cs.LottieProperty

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.ELLIPSE)
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	This.position:=cs.LottieProperty.new(This; $const.PropertyType.POSITION)
	This.size:=cs.LottieProperty.new(This; $const.PropertyType.SIZE)
	
	This.position.staticValue:=[0; 0]
	This.size.staticValue:=[100; 100]

// Parse ellipse from JSON
Function fromJSON($json : Object) : cs.LottieEllipse
	
	Super.fromJSON($json)
	
	// Position (p)
	If ($json.p#Null)
		This.position.fromJSON($json.p)
	End if 
	
	// Size (s)
	If ($json.s#Null)
		This.size.fromJSON($json.s)
	End if 
	
	return This

// Serialize ellipse to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.p:=This.position.toJSON()
	$json.s:=This.size.toJSON()
	
	return $json
