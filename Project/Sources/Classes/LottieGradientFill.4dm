property gradientType : Integer
property startPoint : cs.LottieProperty
property endPoint : cs.LottieProperty
property colors : cs.LottieProperty
property opacity : cs.LottieProperty
property fillRule : Integer
property highlightLength : cs.LottieProperty
property highlightAngle : cs.LottieProperty
property _colorCount : Integer

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.GRADIENT_FILL)
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	This.gradientType:=$const.GradientType.LINEAR
	This.startPoint:=cs.LottieProperty.new(This; "s")
	This.endPoint:=cs.LottieProperty.new(This; "e")
	This.colors:=cs.LottieProperty.new(This; "g")
	This.opacity:=cs.LottieProperty.new(This; $const.PropertyType.OPACITY)
	This.fillRule:=$const.FillRule.NON_ZERO
	
	This.startPoint.staticValue:=[0; 0]
	This.endPoint.staticValue:=[100; 0]
	This.opacity.staticValue:=100

// Parse gradient fill from JSON
Function fromJSON($json : Object) : cs.LottieGradientFill
	
	Super.fromJSON($json)
	
	// Gradient type (t)
	If ($json.t#Null)
		This.gradientType:=$json.t
	End if 
	
	// Start point (s)
	If ($json.s#Null)
		This.startPoint.fromJSON($json.s)
	End if 
	
	// End point (e)
	If ($json.e#Null)
		This.endPoint.fromJSON($json.e)
	End if 
	
	// Colors (g)
	If ($json.g#Null)
		If ($json.g.k#Null)
			This.colors.fromJSON($json.g.k)
		End if 
		This._colorCount:=$json.g.p
	End if 
	
	// Opacity (o)
	If ($json.o#Null)
		This.opacity.fromJSON($json.o)
	End if 
	
	// Fill rule (r)
	If ($json.r#Null)
		This.fillRule:=$json.r
	End if 
	
	// Highlight length (h) - for radial
	If ($json.h#Null)
		This.highlightLength:=cs.LottieProperty.new(This; "h")
		This.highlightLength.fromJSON($json.h)
	End if 
	
	// Highlight angle (a) - for radial
	If ($json.a#Null)
		This.highlightAngle:=cs.LottieProperty.new(This; "a")
		This.highlightAngle.fromJSON($json.a)
	End if 
	
	return This

// Serialize gradient fill to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.t:=This.gradientType
	$json.s:=This.startPoint.toJSON()
	$json.e:=This.endPoint.toJSON()
	$json.o:=This.opacity.toJSON()
	$json.r:=This.fillRule
	
	// Colors with count
	$json.g:={k: This.colors.toJSON(); p: This._colorCount}
	
	If (This.highlightLength#Null)
		$json.h:=This.highlightLength.toJSON()
	End if 
	
	If (This.highlightAngle#Null)
		$json.a:=This.highlightAngle.toJSON()
	End if 
	
	return $json

// Check if radial gradient
Function get isRadial() : Boolean
	
	return This.gradientType=cs.LottieConstants.me.GradientType.RADIAL
