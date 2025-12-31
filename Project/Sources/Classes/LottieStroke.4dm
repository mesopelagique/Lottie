property color : cs.LottieProperty
property opacity : cs.LottieProperty
property width : cs.LottieProperty
property lineCap : Integer
property lineJoin : Integer
property miterLimit : Real
property dashes : Collection

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.STROKE)
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	This.color:=cs.LottieProperty.new(This; $const.PropertyType.COLOR)
	This.opacity:=cs.LottieProperty.new(This; $const.PropertyType.OPACITY)
	This.width:=cs.LottieProperty.new(This; $const.PropertyType.STROKE_WIDTH)
	This.lineCap:=$const.LineCap.ROUND
	This.lineJoin:=$const.LineJoin.ROUND
	This.miterLimit:=4
	This.dashes:=[]
	
	This.color.staticValue:=[0; 0; 0]  // Black default
	This.opacity.staticValue:=100
	This.width.staticValue:=2

// Parse stroke from JSON
Function fromJSON($json : Object) : cs.LottieStroke
	
	Super.fromJSON($json)
	
	// Color (c)
	If ($json.c#Null)
		This.color.fromJSON($json.c)
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
	
	// Miter limit (ml / ml2)
	If ($json.ml#Null)
		This.miterLimit:=$json.ml
	End if 
	If ($json.ml2#Null)
		// ml2 is animated version
		This.miterLimit:=$json.ml2.k
	End if 
	
	// Dashes (d)
	If ($json.d#Null)
		This.dashes:=$json.d
	End if 
	
	return This

// Serialize stroke to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.c:=This.color.toJSON()
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
	
	return $json

// Get color at frame as [r, g, b] (0-1 range)
Function getColor($frame : Real) : Collection
	
	return This.color.getValue($frame)

// Get stroke width at frame
Function getWidth($frame : Real) : Real
	
	return This.width.getValue($frame)
