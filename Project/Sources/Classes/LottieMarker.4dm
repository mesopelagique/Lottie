property name : Text
property time : Real
property duration : Real
property comment : Text
property _parent : Object

Class constructor($parent : Object)
	
	This._parent:=$parent
	This.name:=""
	This.time:=0
	This.duration:=0
	This.comment:=""

// Parse marker from JSON
Function fromJSON($json : Object) : cs.LottieMarker
	
	// Name (cm)
	If ($json.cm#Null)
		This.name:=$json.cm
	End if 
	
	// Time (tm)
	If ($json.tm#Null)
		This.time:=$json.tm
	End if 
	
	// Duration (dr)
	If ($json.dr#Null)
		This.duration:=$json.dr
	End if 
	
	return This

// Serialize marker to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	$json.cm:=This.name
	$json.tm:=This.time
	$json.dr:=This.duration
	
	return $json

// Get end time
Function get endTime() : Real
	
	return This.time+This.duration
