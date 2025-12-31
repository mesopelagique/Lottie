property position : cs.LottieProperty
property innerRadius : cs.LottieProperty
property innerRoundness : cs.LottieProperty
property outerRadius : cs.LottieProperty
property outerRoundness : cs.LottieProperty
property rotation : cs.LottieProperty
property points : cs.LottieProperty
property starType : Integer

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.STAR)
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	This.position:=cs.LottieProperty.new(This; $const.PropertyType.POSITION)
	This.innerRadius:=cs.LottieProperty.new(This; "ir")
	This.innerRoundness:=cs.LottieProperty.new(This; "is")
	This.outerRadius:=cs.LottieProperty.new(This; "or")
	This.outerRoundness:=cs.LottieProperty.new(This; "os")
	This.rotation:=cs.LottieProperty.new(This; $const.PropertyType.ROTATION)
	This.points:=cs.LottieProperty.new(This; "pt")
	
	This.starType:=cs.LottieConstants.me.StarType.STAR
	
	This.position.staticValue:=[0; 0]
	This.outerRadius.staticValue:=100
	This.innerRadius.staticValue:=50
	This.points.staticValue:=5

// Parse star from JSON
Function fromJSON($json : Object) : cs.LottieStar
	
	Super.fromJSON($json)
	
	// Star type (sy)
	If ($json.sy#Null)
		This.starType:=$json.sy
	End if 
	
	// Position (p)
	If ($json.p#Null)
		This.position.fromJSON($json.p)
	End if 
	
	// Inner radius (ir)
	If ($json.ir#Null)
		This.innerRadius.fromJSON($json.ir)
	End if 
	
	// Inner roundness (is)
	If ($json.is#Null)
		This.innerRoundness.fromJSON($json.is)
	End if 
	
	// Outer radius (or)
	If ($json.or#Null)
		This.outerRadius.fromJSON($json.or)
	End if 
	
	// Outer roundness (os)
	If ($json.os#Null)
		This.outerRoundness.fromJSON($json.os)
	End if 
	
	// Rotation (r)
	If ($json.r#Null)
		This.rotation.fromJSON($json.r)
	End if 
	
	// Points (pt)
	If ($json.pt#Null)
		This.points.fromJSON($json.pt)
	End if 
	
	return This

// Serialize star to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.sy:=This.starType
	$json.p:=This.position.toJSON()
	$json.or:=This.outerRadius.toJSON()
	$json.r:=This.rotation.toJSON()
	$json.pt:=This.points.toJSON()
	
	// Only include inner radius/roundness for star type (not polygon)
	If (This.starType=cs.LottieConstants.me.StarType.STAR)
		$json.ir:=This.innerRadius.toJSON()
		If (This.innerRoundness#Null)
			$json.is:=This.innerRoundness.toJSON()
		End if 
	End if 
	
	If (This.outerRoundness#Null)
		$json.os:=This.outerRoundness.toJSON()
	End if 
	
	return $json

// Check if this is a polygon (not a star)
Function get isPolygon() : Boolean
	
	return This.starType=cs.LottieConstants.me.StarType.POLYGON
