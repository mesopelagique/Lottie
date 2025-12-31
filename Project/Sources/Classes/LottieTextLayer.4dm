property textData : Object
property textAnimator : Object
property _textContent : Text
property _fontSize : Real
property _fontFamily : Text
property _fillColor : Collection
property _strokeColor : Collection
property _strokeWidth : Real
property _justify : Integer
property _lineHeight : Real
property _tracking : Real

Class extends LottieLayer

Class constructor
	
	Super(cs.LottieConstants.me.LayerType.TEXT)
	This.textData:={}

// Parse text layer from JSON
Function fromJSON($json : Object) : cs.LottieTextLayer
	
	// Parse base layer properties
	Super.fromJSON($json)
	
	// Text data (t)
	If ($json.t#Null)
		This.textData:=$json.t
		
		// Parse document data if present
		If ($json.t.d#Null)
			This._parseTextDocument($json.t.d)
		End if 
	End if 
	
	return This

// Parse text document data
Function _parseTextDocument($docData : Object)
	
	// Text document is in d.k[0].s for static or d.k for animated
	If ($docData.k#Null)
		If (Value type($docData.k)=Is collection)
			var $kColl : Collection:=$docData.k
			If ($kColl.length>0)
				var $firstK : Object:=$kColl[0]
				If ($firstK.s#Null)
					This._textContent:=$firstK.s.t
					This._fontSize:=$firstK.s.s
					This._fontFamily:=$firstK.s.f
					This._fillColor:=$firstK.s.fc
					This._strokeColor:=$firstK.s.sc
					This._strokeWidth:=$firstK.s.sw
					This._justify:=$firstK.s.j
					This._lineHeight:=$firstK.s.lh
					This._tracking:=$firstK.s.tr
				End if 
			End if 
		End if 
	End if 

// Serialize text layer to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	$json.t:=This.textData
	
	return $json

// Get text content
Function get text() : Text
	
	If (This._textContent#Null)
		return This._textContent
	End if 
	
	// Try to extract from textData
	If (This.textData.d#Null) & (This.textData.d.k#Null)
		var $k : Collection:=This.textData.d.k
		If ($k.length>0) & ($k[0].s#Null)
			return $k[0].s.t
		End if 
	End if 
	
	return ""

// Set text content
Function set text($value : Text)
	
	This._textContent:=$value
	
	If (This.textData.d#Null) & (This.textData.d.k#Null)
		var $k : Collection:=This.textData.d.k
		If ($k.length>0) & ($k[0].s#Null)
			$k[0].s.t:=$value
		End if 
	End if 

// Get font size
Function get fontSize() : Real
	
	If (This._fontSize#Null)
		return This._fontSize
	End if 
	return 0

// Get font family
Function get fontFamily() : Text
	
	If (This._fontFamily#Null)
		return This._fontFamily
	End if 
	return ""

// Get fill color as [r, g, b] (0-1 range)
Function get fillColor() : Collection
	
	If (This._fillColor#Null)
		return This._fillColor
	End if 
	return Null

// Get justify
Function get justify() : Integer
	
	If (This._justify#Null)
		return This._justify
	End if 
	return 0
