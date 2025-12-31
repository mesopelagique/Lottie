property copies : cs.LottieProperty
property offset : cs.LottieProperty
property composite : Integer
property transform : cs.LottieTransform

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.REPEATER)
	
	This.copies:=cs.LottieProperty.new(This; "c")
	This.offset:=cs.LottieProperty.new(This; "o")
	This.composite:=cs.LottieConstants.me.RepeaterComposite.ABOVE
	This.transform:=cs.LottieTransform.new(This)
	
	This.copies.staticValue:=3
	This.offset.staticValue:=0

// Parse repeater from JSON
Function fromJSON($json : Object) : cs.LottieRepeater
	
	Super.fromJSON($json)
	
	// Copies (c)
	If ($json.c#Null)
		This.copies.fromJSON($json.c)
	End if 
	
	// Offset (o)
	If ($json.o#Null)
		This.offset.fromJSON($json.o)
	End if 
	
	// Composite (m)
	If ($json.m#Null)
		This.composite:=$json.m
	End if 
	
	// Transform (tr)
	If ($json.tr#Null)
		This.transform.fromJSON($json.tr)
	End if 
	
	return This

// Serialize repeater to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.c:=This.copies.toJSON()
	$json.o:=This.offset.toJSON()
	$json.m:=This.composite
	$json.tr:=This.transform.toJSON()
	
	return $json
