property amount : cs.LottieProperty

Class extends LottieShape

Class constructor
	
	Super(cs.LottieConstants.me.ShapeType.PUCKER_BLOAT)
	
	This.amount:=cs.LottieProperty.new(This; "a")
	This.amount.staticValue:=0

// Parse pucker bloat from JSON
Function fromJSON($json : Object) : cs.LottiePuckerBloat
	
	Super.fromJSON($json)
	
	// Amount (a)
	If ($json.a#Null)
		This.amount.fromJSON($json.a)
	End if 
	
	return This

// Serialize pucker bloat to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.a:=This.amount.toJSON()
	
	return $json
