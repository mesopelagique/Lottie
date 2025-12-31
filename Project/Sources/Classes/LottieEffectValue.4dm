property name : Text
property matchName : Text
property type : Integer
property index : Integer
property value : cs.LottieProperty
property _parent : Object

Class constructor($parent : Object)
	
	This._parent:=$parent
	This.name:=""
	This.type:=0
	This.value:=cs.LottieProperty.new(This; "v")

// Parse effect value from JSON
Function fromJSON($json : Object) : cs.LottieEffectValue
	
	// Name (nm)
	If ($json.nm#Null)
		This.name:=$json.nm
	End if 
	
	// Match name (mn)
	If ($json.mn#Null)
		This.matchName:=$json.mn
	End if 
	
	// Type (ty)
	If ($json.ty#Null)
		This.type:=$json.ty
	End if 
	
	// Index (ix)
	If ($json.ix#Null)
		This.index:=$json.ix
	End if 
	
	// Value (v)
	If ($json.v#Null)
		This.value.fromJSON($json.v)
	End if 
	
	return This

// Serialize effect value to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	If (This.name#"")
		$json.nm:=This.name
	End if 
	
	If (This.matchName#Null) & (This.matchName#"")
		$json.mn:=This.matchName
	End if 
	
	$json.ty:=This.type
	
	If (This.index#Null)
		$json.ix:=This.index
	End if 
	
	$json.v:=This.value.toJSON()
	
	return $json
