property refId : Text

Class extends LottieLayer

Class constructor
	
	Super(cs.LottieConstants.me.LayerType.IMAGE)
	This.refId:=""

// Parse image layer from JSON
Function fromJSON($json : Object) : cs.LottieImageLayer
	
	// Parse base layer properties
	Super.fromJSON($json)
	
	// Reference ID (refId)
	If ($json.refId#Null)
		This.refId:=$json.refId
	End if 
	
	return This

// Serialize image layer to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.refId:=This.refId
	
	return $json

// Get referenced asset from parent animation
Function getAsset() : cs.LottieImageAsset
	
	If (This._parent#Null)
		var $animation : cs.Lottie:=This._parent
		return $animation.getAssetById(This.refId)
	End if 
	return Null
