property layers : Collection
property name : Text
property frameRate : Real

Class extends LottieAsset

Class constructor
	
	Super()
	This.layers:=[]
	This.name:=""

// Parse precomp asset from JSON
Function fromJSON($json : Object) : cs.LottiePrecompAsset
	
	Super.fromJSON($json)
	
	// Name (nm)
	If ($json.nm#Null)
		This.name:=$json.nm
	End if 
	
	// Frame rate (fr)
	If ($json.fr#Null)
		This.frameRate:=$json.fr
	End if 
	
	// Layers (layers)
	If ($json.layers#Null)
		var $layerJson : Object
		For each ($layerJson; $json.layers)
			var $layer : cs.LottieLayer:=cs.LottieLayer.new(0).createFromJSON($layerJson; This)
			This.layers.push($layer)
		End for each 
	End if 
	
	return This

// Serialize precomp asset to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	If (This.name#"")
		$json.nm:=This.name
	End if 
	
	If (This.frameRate#Null) & (This.frameRate>0)
		$json.fr:=This.frameRate
	End if 
	
	If (This.layers.length>0)
		$json.layers:=[]
		var $layer : cs.LottieLayer
		For each ($layer; This.layers)
			$json.layers.push($layer.toJSON())
		End for each 
	End if 
	
	return $json

// Get layer by name
Function getLayerByName($name : Text) : cs.LottieLayer
	
	var $layer : cs.LottieLayer
	For each ($layer; This.layers)
		If ($layer.name=$name)
			return $layer
		End if 
	End for each 
	return Null

// Get layers by type
Function getLayersByType($type : Integer) : Collection
	
	var $result : Collection:=[]
	var $layer : cs.LottieLayer
	For each ($layer; This.layers)
		If ($layer.type=$type)
			$result.push($layer)
		End if 
	End for each 
	return $result
