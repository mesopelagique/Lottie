property name : Text
property mode : Text
property opacity : cs.LottieProperty
property points : cs.LottieProperty
property inverted : Boolean
property expand : cs.LottieProperty
property _parent : Object

Class constructor($parent : Object)
	
	This._parent:=$parent
	This.name:=""
	This.mode:=cs.LottieConstants.me.MaskMode.ADD
	This.inverted:=False
	
	This.opacity:=cs.LottieProperty.new(This; cs.LottieConstants.me.PropertyType.OPACITY)
	This.points:=cs.LottieProperty.new(This; cs.LottieConstants.me.PropertyType.SHAPE)
	
	This.opacity.staticValue:=100

// Parse mask from JSON
Function fromJSON($json : Object) : cs.LottieMask
	
	// Name (nm)
	If ($json.nm#Null)
		This.name:=$json.nm
	End if 
	
	// Mode (mode)
	If ($json.mode#Null)
		This.mode:=$json.mode
	End if 
	
	// Opacity (o)
	If ($json.o#Null)
		This.opacity.fromJSON($json.o)
	End if 
	
	// Points/vertices (pt)
	If ($json.pt#Null)
		This.points.fromJSON($json.pt)
	End if 
	
	// Inverted (inv)
	This.inverted:=Bool($json.inv)
	
	// Expand (x)
	If ($json.x#Null)
		This.expand:=cs.LottieProperty.new(This; "x")
		This.expand.fromJSON($json.x)
	End if 
	
	return This

// Serialize mask to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	If (This.name#"")
		$json.nm:=This.name
	End if 
	
	$json.mode:=This.mode
	$json.o:=This.opacity.toJSON()
	$json.pt:=This.points.toJSON()
	
	If (This.inverted)
		$json.inv:=True
	End if 
	
	If (This.expand#Null)
		$json.x:=This.expand.toJSON()
	End if 
	
	return $json
