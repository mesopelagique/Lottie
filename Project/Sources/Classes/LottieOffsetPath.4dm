property amount : cs.LottieProperty
property lineJoin : Integer
property miterLimit : Real

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.OFFSET_PATH)
	
	This.amount:=cs.LottieProperty.new(This; "a")
	This.lineJoin:=cs.LottieConstants.me.LineJoin.MITER
	This.miterLimit:=4
	
	This.amount.staticValue:=0

// Parse offset path from JSON
Function fromJSON($json : Object) : cs.LottieOffsetPath
	
	Super.fromJSON($json)
	
	// Amount (a)
	If ($json.a#Null)
		This.amount.fromJSON($json.a)
	End if 
	
	// Line join (lj)
	If ($json.lj#Null)
		This.lineJoin:=$json.lj
	End if 
	
	// Miter limit (ml)
	If ($json.ml#Null)
		This.miterLimit:=$json.ml.k
	End if 
	
	return This

// Serialize offset path to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.a:=This.amount.toJSON()
	$json.lj:=This.lineJoin
	$json.ml:={a: 0; k: This.miterLimit}
	
	return $json
