property vertices : cs.LottieProperty

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.PATH)
	
	This.vertices:=cs.LottieProperty.new(This; cs.LottieConstants.me.PropertyType.SHAPE)

// Parse path from JSON
Function fromJSON($json : Object) : cs.LottiePath
	
	Super.fromJSON($json)
	
	// Vertices/shape (ks)
	If ($json.ks#Null)
		This.vertices.fromJSON($json.ks)
	End if 
	
	return This

// Serialize path to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.ks:=This.vertices.toJSON()
	
	return $json

// Get path data at frame
Function getPathData($frame : Real) : Object
	
	var $value : Variant:=This.vertices.getValue($frame)
	
	If (Value type($value)=Is object)
		return $value
	End if 
	
	// Return empty path data structure
	return {i: []; o: []; v: []; c: False}

// Check if path is closed
Function get isClosed() : Boolean
	
	var $data : Object:=This.getPathData(0)
	return Bool($data.c)
