property path : Text
property data : Text
property width : Integer
property height : Integer
property isEmbedded : Boolean

Class extends LottieAsset

Class constructor
	
	Super()
	This.path:=""
	This.data:=""
	This.width:=0
	This.height:=0
	This.isEmbedded:=False

// Parse image asset from JSON
Function fromJSON($json : Object) : cs.LottieImageAsset
	
	Super.fromJSON($json)
	
	// Path/URL prefix (u)
	If ($json.u#Null)
		This.path:=$json.u
	End if 
	
	// Data/filename (p)
	If ($json.p#Null)
		This.data:=$json.p
		// Check if embedded base64
		This.isEmbedded:=(Position("data:"; This.data)=1)
	End if 
	
	// Width (w)
	If ($json.w#Null)
		This.width:=$json.w
	End if 
	
	// Height (h)
	If ($json.h#Null)
		This.height:=$json.h
	End if 
	
	// Embedded flag (e)
	If ($json.e#Null)
		This.isEmbedded:=Bool($json.e)
	End if 
	
	return This

// Serialize image asset to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.u:=This.path
	$json.p:=This.data
	$json.w:=This.width
	$json.h:=This.height
	
	If (This.isEmbedded)
		$json.e:=1
	End if 
	
	return $json

// Get full URL/path
Function get fullPath() : Text
	
	If (This.isEmbedded)
		return This.data
	End if 
	return This.path+This.data

// Get filename without path
Function get fileName() : Text
	
	If (This.isEmbedded)
		return ""
	End if 
	return This.data

// Check if PNG
Function get isPNG() : Boolean
	
	var $lower : Text:=Lowercase(This.data)
	return (Position(".png"; $lower)>0) | (Position("image/png"; $lower)>0)

// Check if JPEG
Function get isJPEG() : Boolean
	
	var $lower : Text:=Lowercase(This.data)
	return (Position(".jpg"; $lower)>0) | (Position(".jpeg"; $lower)>0) | (Position("image/jpeg"; $lower)>0)
