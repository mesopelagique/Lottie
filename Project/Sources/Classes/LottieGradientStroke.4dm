property gradientType : Integer
property startPoint : cs.LottieProperty
property endPoint : cs.LottieProperty
property colors : cs.LottieProperty
property opacity : cs.LottieProperty
property width : cs.LottieProperty
property lineCap : Integer
property lineJoin : Integer
property miterLimit : Real
property dashes : Collection
property highlightLength : cs.LottieProperty
property highlightAngle : cs.LottieProperty
property _colorCount : Integer

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.GRADIENT_STROKE)
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	This.gradientType:=$const.GradientType.LINEAR
	This.startPoint:=cs.LottieProperty.new(This; "s")
	This.endPoint:=cs.LottieProperty.new(This; "e")
	This.colors:=cs.LottieProperty.new(This; "g")
	This.opacity:=cs.LottieProperty.new(This; $const.PropertyType.OPACITY)
	This.width:=cs.LottieProperty.new(This; $const.PropertyType.STROKE_WIDTH)
	This.lineCap:=$const.LineCap.ROUND
	This.lineJoin:=$const.LineJoin.ROUND
	This.miterLimit:=4
	This.dashes:=[]
	
	This.startPoint.staticValue:=[0; 0]
	This.endPoint.staticValue:=[100; 0]
	This.opacity.staticValue:=100
	This.width.staticValue:=2

// Parse gradient stroke from JSON
Function fromJSON($json : Object) : cs.LottieGradientStroke
	
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
	
	// Width (w)
	If ($json.w#Null)
		This.width.fromJSON($json.w)
	End if 
	
	// Line cap (lc)
	If ($json.lc#Null)
		This.lineCap:=$json.lc
	End if 
	
	// Line join (lj)
	If ($json.lj#Null)
		This.lineJoin:=$json.lj
	End if 
	
	// Miter limit (ml)
	If ($json.ml#Null)
		This.miterLimit:=$json.ml
	End if 
	
	// Dashes (d)
	If ($json.d#Null)
		This.dashes:=$json.d
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

// Serialize gradient stroke to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.t:=This.gradientType
	$json.s:=This.startPoint.toJSON()
	$json.e:=This.endPoint.toJSON()
	$json.o:=This.opacity.toJSON()
	$json.w:=This.width.toJSON()
	$json.lc:=This.lineCap
	$json.lj:=This.lineJoin
	
	If (This.miterLimit#4)
		$json.ml:=This.miterLimit
	End if 
	
	If (This.dashes.length>0)
		$json.d:=This.dashes
	End if 
	
	// Colors with count
	$json.g:={k: This.colors.toJSON(); p: This._colorCount}
	
	If (This.highlightLength#Null)
		$json.h:=This.highlightLength.toJSON()
	End if 
	
	If (This.highlightAngle#Null)
		$json.a:=This.highlightAngle.toJSON()
	End if 
	
	return $json
