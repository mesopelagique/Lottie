property name : Text
property matchName : Text
property type : Integer
property index : Integer
property enabled : Boolean
property values : Collection
property _parent : Object

Class constructor($parent : Object)
	
	This._parent:=$parent
	This.name:=""
	This.enabled:=True
	This.values:=[]

// Parse effect from JSON
Function fromJSON($json : Object) : cs.LottieEffect
	
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
	
	// Enabled (en)
	If ($json.en#Null)
		This.enabled:=Bool($json.en)
	Else 
		This.enabled:=True
	End if 
	
	// Effect values (ef)
	If ($json.ef#Null)
		var $valJson : Object
		For each ($valJson; $json.ef)
			var $effVal : cs.LottieEffectValue:=cs.LottieEffectValue.new(This)
			$effVal.fromJSON($valJson)
			This.values.push($effVal)
		End for each 
	End if 
	
	return This

// Serialize effect to JSON
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
	
	$json.en:=This.enabled ? 1 : 0
	
	If (This.values.length>0)
		$json.ef:=[]
		var $effVal : cs.LottieEffectValue
		For each ($effVal; This.values)
			$json.ef.push($effVal.toJSON())
		End for each 
	End if 
	
	return $json

// Get effect type name
Function get typeName() : Text
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	var $key : Text
	For each ($key; $const.EffectType)
		If ($const.EffectType[$key]=This.type)
			return $key
		End if 
	End for each 
	return "UNKNOWN"
