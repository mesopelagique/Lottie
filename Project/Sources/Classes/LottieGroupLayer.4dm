Class extends LottieLayer

Class constructor
	
	Super(cs.LottieConstants.me.LayerType.GROUP)

// Parse group layer from JSON
Function fromJSON($json : Object) : cs.LottieGroupLayer
	
	// Parse base layer properties
	Super.fromJSON($json)
	
	return This

// Serialize group layer to JSON
Function toJSON() : Object
	
	return Super.toJSON()
