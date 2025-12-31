property refId : Text
property width : Integer
property height : Integer
property timeRemap : cs.LottieProperty

Class extends LottieLayer

Class constructor
	
	Super(cs.LottieConstants.me.LayerType.PRECOMP)
	This.refId:=""
	This.width:=0
	This.height:=0

// Parse precomp layer from JSON
Function fromJSON($json : Object) : cs.LottiePrecompLayer
	
	// Parse base layer properties
	Super.fromJSON($json)
	
	// Reference ID (refId)
	If ($json.refId#Null)
		This.refId:=$json.refId
	End if 
	
	// Width (w)
	If ($json.w#Null)
		This.width:=$json.w
	End if 
	
	// Height (h)
	If ($json.h#Null)
		This.height:=$json.h
	End if 
	
	// Time remap (tm)
	If ($json.tm#Null)
		var $const : cs.LottieConstants:=cs.LottieConstants.me
		This.timeRemap:=cs.LottieProperty.new(This; "tm")
		This.timeRemap.fromJSON($json.tm)
	End if 
	
	return This

// Serialize precomp layer to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.refId:=This.refId
	
	If (This.width>0)
		$json.w:=This.width
	End if 
	
	If (This.height>0)
		$json.h:=This.height
	End if 
	
	If (This.timeRemap#Null)
		$json.tm:=This.timeRemap.toJSON()
	End if 
	
	return $json

// Get referenced asset from parent animation
Function getAsset() : cs.LottiePrecompAsset
	
	If (This._parent#Null)
		var $animation : cs.Lottie:=This._parent
		return $animation.getAssetById(This.refId)
	End if 
	return Null

// Get precomp layers
Function get layers() : Collection
	
	var $asset : cs.LottiePrecompAsset:=This.getAsset()
	If ($asset#Null)
		return $asset.layers
	End if 
	return []
