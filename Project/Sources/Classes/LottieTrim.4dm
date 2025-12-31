property start : cs.LottieProperty
property end : cs.LottieProperty
property offset : cs.LottieProperty
property trimMode : Integer

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.TRIM)
	
	This.start:=cs.LottieProperty.new(This; "s")
	This.end:=cs.LottieProperty.new(This; "e")
	This.offset:=cs.LottieProperty.new(This; "o")
	This.trimMode:=cs.LottieConstants.me.TrimMode.SIMULTANEOUSLY
	
	This.start.staticValue:=0
	This.end.staticValue:=100
	This.offset.staticValue:=0

// Parse trim from JSON
Function fromJSON($json : Object) : cs.LottieTrim
	
	Super.fromJSON($json)
	
	// Start (s)
	If ($json.s#Null)
		This.start.fromJSON($json.s)
	End if 
	
	// End (e)
	If ($json.e#Null)
		This.end.fromJSON($json.e)
	End if 
	
	// Offset (o)
	If ($json.o#Null)
		This.offset.fromJSON($json.o)
	End if 
	
	// Trim mode (m)
	If ($json.m#Null)
		This.trimMode:=$json.m
	End if 
	
	return This

// Serialize trim to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.s:=This.start.toJSON()
	$json.e:=This.end.toJSON()
	$json.o:=This.offset.toJSON()
	$json.m:=This.trimMode
	
	return $json
