property generator : Text
property author : Text
property keywords : Collection
property description : Text
property themeColor : Text
property _parent : Object

Class constructor($parent : Object)
	
	This._parent:=$parent
	This.generator:=""
	This.author:=""
	This.keywords:=[]
	This.description:=""
	This.themeColor:=""

// Parse meta from JSON
Function fromJSON($json : Object) : cs.LottieMeta
	
	// Generator (g)
	If ($json.g#Null)
		This.generator:=$json.g
	End if 
	
	// Author (a)
	If ($json.a#Null)
		This.author:=$json.a
	End if 
	
	// Keywords (k)
	If ($json.k#Null)
		If (Value type($json.k)=Is text)
			This.keywords:=Split string($json.k; ", ")
		Else 
			This.keywords:=$json.k
		End if 
	End if 
	
	// Description (d)
	If ($json.d#Null)
		This.description:=$json.d
	End if 
	
	// Theme color (tc)
	If ($json.tc#Null)
		This.themeColor:=$json.tc
	End if 
	
	return This

// Serialize meta to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	If (This.generator#"")
		$json.g:=This.generator
	End if 
	
	If (This.author#"")
		$json.a:=This.author
	End if 
	
	If (This.keywords.length>0)
		$json.k:=This.keywords.join(", ")
	End if 
	
	If (This.description#"")
		$json.d:=This.description
	End if 
	
	If (This.themeColor#"")
		$json.tc:=This.themeColor
	End if 
	
	return $json
