property version : Text
property frameRate : Real
property width : Integer
property height : Integer
property inPoint : Real
property outPoint : Real
property name : Text
property is3D : Boolean
property layers : Collection
property assets : Collection
property markers : Collection
property fonts : cs:C1710.LottieFontList
property characters : Collection
property meta : cs:C1710.LottieMeta

Class constructor($data : Variant)
	
	// Initialize default values
	This:C1470.version:=""
	This:C1470.frameRate:=60
	This:C1470.width:=0
	This:C1470.height:=0
	This:C1470.inPoint:=0
	This:C1470.outPoint:=0
	This:C1470.name:=""
	This:C1470.is3D:=False:C215
	This:C1470.layers:=[]
	This:C1470.assets:=[]
	This:C1470.markers:=[]
	This:C1470.fonts:=cs:C1710.LottieFontList.new()
	This:C1470.characters:=[]
	This:C1470.meta:=cs:C1710.LottieMeta.new(This:C1470)
	
	// Handle different input types
	Case of 
		: (Value type:C1509($data)=Is text:K8:3)
			This:C1470._handleTextInput($data)
			
		: (Value type:C1509($data)=Is object:K8:27)
			This:C1470._handleObjectInput($data)
			
		: ($data=Null:C1517)
			// Empty animation, no initialization needed
			
		Else 
			throw:C1805(1; "Invalid data type. Expected Text, Object, or 4D.File")
	End case 
	
	// Handle text input (JSON string or file path)
Function _handleTextInput($text : Text)
	
	var $trimmed : Text:=This:C1470._trim($text)
	
	// Check if it's JSON (starts with {)
	Case of 
		: ($trimmed[[1]]="{")
			var $json : Object:=JSON Parse:C1218($trimmed)
			If ($json=Null:C1517)
				throw:C1805(2; "Invalid JSON data")
			End if 
			This:C1470._validate($json)
			This:C1470.fromJSON($json)
			
		: ((Position:C15("/"; $text)>0) || (Position:C15(Folder separator:K24:12; $text)>0))
			// Check if it contains path separators
			
			// It's a file path
			var $file : 4D:C1709.File:=File:C1566($text; (Position:C15("/"; $text)>0) ? fk posix path:K87:1 : fk platform path:K87:2)
			If (Not:C34($file.exists))
				throw:C1805(3; "File not found: "+$text)
			End if 
			var $content : Text:=$file.getText("UTF-8")
			var $json2 : Object:=JSON Parse:C1218($content)
			If ($json2=Null:C1517)
				throw:C1805(4; "Invalid JSON in file: "+$text)
			End if 
			This:C1470._validate($json2)
			This:C1470.fromJSON($json2)
			
			
		Else 
			throw:C1805(5; "Invalid input: not JSON and not a file path")
	End case 
	
	// Handle object input (4D.File or JSON object)
Function _handleObjectInput($obj : Object)
	
	// Check if it's a 4D.File
	If (OB Instance of:C1731($obj; 4D:C1709.File))
		var $file : 4D:C1709.File:=$obj
		If (Not:C34($file.exists))
			throw:C1805(3; "File not found: "+$file.path)
		End if 
		var $content : Text:=$file.getText("UTF-8")
		var $json : Object:=JSON Parse:C1218($content)
		If ($json=Null:C1517)
			throw:C1805(4; "Invalid JSON in file: "+$file.path)
		End if 
		This:C1470._validate($json)
		This:C1470.fromJSON($json)
	Else 
		// Assume it's a JSON object
		This:C1470._validate($obj)
		This:C1470.fromJSON($obj)
	End if 
	
	// Validate Lottie JSON structure
Function _validate($json : Object)
	
	// Required fields: v, fr, ip, op, w, h, layers
	If ($json.v=Null:C1517)
		throw:C1805(10; "Invalid Lottie: missing version (v)")
	End if 
	
	If ($json.fr=Null:C1517)
		throw:C1805(11; "Invalid Lottie: missing frame rate (fr)")
	End if 
	
	If ($json.ip=Null:C1517)
		throw:C1805(12; "Invalid Lottie: missing in point (ip)")
	End if 
	
	If ($json.op=Null:C1517)
		throw:C1805(13; "Invalid Lottie: missing out point (op)")
	End if 
	
	If ($json.w=Null:C1517)
		throw:C1805(14; "Invalid Lottie: missing width (w)")
	End if 
	
	If ($json.h=Null:C1517)
		throw:C1805(15; "Invalid Lottie: missing height (h)")
	End if 
	
	If ($json.layers=Null:C1517)
		throw:C1805(16; "Invalid Lottie: missing layers")
	End if 
	
	// Parse Lottie JSON
Function fromJSON($json : Object) : cs:C1710.Lottie
	
	// Version (v)
	If ($json.v#Null:C1517)
		This:C1470.version:=$json.v
	End if 
	
	// Frame rate (fr)
	If ($json.fr#Null:C1517)
		This:C1470.frameRate:=$json.fr
	End if 
	
	// Width (w)
	If ($json.w#Null:C1517)
		This:C1470.width:=$json.w
	End if 
	
	// Height (h)
	If ($json.h#Null:C1517)
		This:C1470.height:=$json.h
	End if 
	
	// In point (ip)
	If ($json.ip#Null:C1517)
		This:C1470.inPoint:=$json.ip
	End if 
	
	// Out point (op)
	If ($json.op#Null:C1517)
		This:C1470.outPoint:=$json.op
	End if 
	
	// Name (nm)
	If ($json.nm#Null:C1517)
		This:C1470.name:=$json.nm
	End if 
	
	// 3D (ddd)
	This:C1470.is3D:=Bool:C1537($json.ddd)
	
	// Assets
	If ($json.assets#Null:C1517)
		var $assetJson : Object
		For each ($assetJson; $json.assets)
			var $asset : cs:C1710.LottieAsset:=cs:C1710.LottieAsset.new().createFromJSON($assetJson; This:C1470)
			This:C1470.assets.push($asset)
		End for each 
	End if 
	
	// Layers
	If ($json.layers#Null:C1517)
		var $layerJson : Object
		For each ($layerJson; $json.layers)
			var $layer : cs:C1710.LottieLayer:=cs:C1710.LottieLayer.new(0).createFromJSON($layerJson; This:C1470)
			This:C1470.layers.push($layer)
		End for each 
	End if 
	
	// Markers
	If ($json.markers#Null:C1517)
		var $markerJson : Object
		For each ($markerJson; $json.markers)
			var $marker : cs:C1710.LottieMarker:=cs:C1710.LottieMarker.new(This:C1470)
			$marker.fromJSON($markerJson)
			This:C1470.markers.push($marker)
		End for each 
	End if 
	
	// Fonts
	If ($json.fonts#Null:C1517)
		This:C1470.fonts.fromJSON($json.fonts)
	End if 
	
	// Characters
	If ($json.chars#Null:C1517)
		var $charJson : Object
		For each ($charJson; $json.chars)
			var $char : cs:C1710.LottieCharacter:=cs:C1710.LottieCharacter.new()
			$char.fromJSON($charJson)
			This:C1470.characters.push($char)
		End for each 
	End if 
	
	// Meta
	If ($json.meta#Null:C1517)
		This:C1470.meta.fromJSON($json.meta)
	End if 
	
	return This:C1470
	
	// Serialize to Lottie JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	$json.v:=This:C1470.version
	$json.fr:=This:C1470.frameRate
	$json.ip:=This:C1470.inPoint
	$json.op:=This:C1470.outPoint
	$json.w:=This:C1470.width
	$json.h:=This:C1470.height
	
	If (This:C1470.name#"")
		$json.nm:=This:C1470.name
	End if 
	
	If (This:C1470.is3D)
		$json.ddd:=1
	Else 
		$json.ddd:=0
	End if 
	
	// Assets
	$json.assets:=[]
	var $asset : cs:C1710.LottieAsset
	For each ($asset; This:C1470.assets)
		$json.assets.push($asset.toJSON())
	End for each 
	
	// Layers
	$json.layers:=[]
	var $layer : cs:C1710.LottieLayer
	For each ($layer; This:C1470.layers)
		$json.layers.push($layer.toJSON())
	End for each 
	
	// Markers
	If (This:C1470.markers.length>0)
		$json.markers:=[]
		var $marker : cs:C1710.LottieMarker
		For each ($marker; This:C1470.markers)
			$json.markers.push($marker.toJSON())
		End for each 
	End if 
	
	// Fonts
	var $fontsJson : Object:=This:C1470.fonts.toJSON()
	If ($fontsJson.list#Null:C1517) & ($fontsJson.list.length>0)
		$json.fonts:=$fontsJson
	End if 
	
	// Characters
	If (This:C1470.characters.length>0)
		$json.chars:=[]
		var $char : cs:C1710.LottieCharacter
		For each ($char; This:C1470.characters)
			$json.chars.push($char.toJSON())
		End for each 
	End if 
	
	// Meta
	var $metaJson : Object:=This:C1470.meta.toJSON()
	If (OB Keys:C1719($metaJson).length>0)
		$json.meta:=$metaJson
	End if 
	
	return $json
	
	// Save to file
Function save($file : Variant) : Boolean
	
	var $targetFile : 4D:C1709.File
	
	If (Value type:C1509($file)=Is text:K8:3)
		$targetFile:=File:C1566($file; fk posix path:K87:1)
	Else 
		If (OB Instance of:C1731($file; 4D:C1709.File))
			$targetFile:=$file
		Else 
			throw:C1805(6; "Invalid file parameter. Expected Text path or 4D.File")
		End if 
	End if 
	
	var $json : Object:=This:C1470.toJSON()
	var $text : Text:=JSON Stringify:C1217($json)
	
	$targetFile.setText($text; "UTF-8")
	
	return True:C214
	
	// Get duration in seconds
Function get duration() : Real
	
	If (This:C1470.frameRate>0)
		return (This:C1470.outPoint-This:C1470.inPoint)/This:C1470.frameRate
	End if 
	return 0
	
	// Get total frames
Function get totalFrames() : Real
	
	return This:C1470.outPoint-This:C1470.inPoint
	
	// Get layer by name
Function getLayerByName($name : Text) : cs:C1710.LottieLayer
	
	var $layer : cs:C1710.LottieLayer
	For each ($layer; This:C1470.layers)
		If ($layer.name=$name)
			return $layer
		End if 
	End for each 
	return Null:C1517
	
	// Get layer by index
Function getLayerByIndex($index : Integer) : cs:C1710.LottieLayer
	
	var $layer : cs:C1710.LottieLayer
	For each ($layer; This:C1470.layers)
		If ($layer.index=$index)
			return $layer
		End if 
	End for each 
	return Null:C1517
	
	// Get layer by ID
Function getLayerById($id : Text) : cs:C1710.LottieLayer
	
	var $layer : cs:C1710.LottieLayer
	For each ($layer; This:C1470.layers)
		If ($layer.id=$id)
			return $layer
		End if 
	End for each 
	return Null:C1517
	
	// Get layers by type
Function getLayersByType($type : Integer) : Collection
	
	var $result : Collection:=[]
	var $layer : cs:C1710.LottieLayer
	For each ($layer; This:C1470.layers)
		If ($layer.type=$type)
			$result.push($layer)
		End if 
	End for each 
	return $result
	
	// Get asset by ID
Function getAssetById($id : Text) : cs:C1710.LottieAsset
	
	var $asset : cs:C1710.LottieAsset
	For each ($asset; This:C1470.assets)
		If ($asset.id=$id)
			return $asset
		End if 
	End for each 
	return Null:C1517
	
	// Get marker by name
Function getMarkerByName($name : Text) : cs:C1710.LottieMarker
	
	var $marker : cs:C1710.LottieMarker
	For each ($marker; This:C1470.markers)
		If ($marker.name=$name)
			return $marker
		End if 
	End for each 
	return Null:C1517
	
	// Get all shape layers
Function get shapeLayers() : Collection
	
	return This:C1470.getLayersByType(cs:C1710.LottieConstants.me.LayerType.SHAPE)
	
	// Get all text layers
Function get textLayers() : Collection
	
	return This:C1470.getLayersByType(cs:C1710.LottieConstants.me.LayerType.TEXT)
	
	// Get all image layers
Function get imageLayers() : Collection
	
	return This:C1470.getLayersByType(cs:C1710.LottieConstants.me.LayerType.IMAGE)
	
	// Get all precomp layers
Function get precompLayers() : Collection
	
	return This:C1470.getLayersByType(cs:C1710.LottieConstants.me.LayerType.PRECOMP)
	
	// Get all colors used in the animation
Function get colors() : Collection
	
	var $colors : Collection:=[]
	This:C1470._collectColors(This:C1470.layers; $colors)
	return $colors
	
	// Collect colors from layers recursively
Function _collectColors($layers : Collection; $colors : Collection)
	
	var $layer : cs:C1710.LottieLayer
	For each ($layer; $layers)
		// Check shape layers
		If ($layer.type=cs:C1710.LottieConstants.me.LayerType.SHAPE)
			var $shapeLayer : cs:C1710.LottieShapeLayer:=$layer
			This:C1470._collectColorsFromShapes($shapeLayer.shapes; $colors)
		End if 
		
		// Check solid layers
		If ($layer.type=cs:C1710.LottieConstants.me.LayerType.SOLID)
			var $solidLayer : cs:C1710.LottieSolidLayer:=$layer
			If ($colors.indexOf($solidLayer.color)<0)
				$colors.push($solidLayer.color)
			End if 
		End if 
	End for each 
	
	// Collect colors from shapes
Function _collectColorsFromShapes($shapes : Collection; $colors : Collection)
	
	var $const : cs:C1710.LottieConstants:=cs:C1710.LottieConstants.me
	var $shape : cs:C1710.LottieShape
	
	For each ($shape; $shapes)
		Case of 
			: ($shape.type=$const.ShapeType.FILL)
				var $fill : cs:C1710.LottieFill:=$shape
				var $color : Variant:=$fill.color.staticValue
				If ($color#Null:C1517)
					$colors.push($color)
				End if 
				
			: ($shape.type=$const.ShapeType.STROKE)
				var $stroke : cs:C1710.LottieStroke:=$shape
				var $strokeColor : Variant:=$stroke.color.staticValue
				If ($strokeColor#Null:C1517)
					$colors.push($strokeColor)
				End if 
				
			: ($shape.type=$const.ShapeType.GROUP)
				var $group : cs:C1710.LottieShapeGroup:=$shape
				This:C1470._collectColorsFromShapes($group.shapes; $colors)
		End case 
	End for each 
	
	// Get all text content
Function get textContent() : Collection
	
	var $result : Collection:=[]
	var $layer : cs:C1710.LottieLayer
	For each ($layer; This:C1470.layers)
		If ($layer.type=cs:C1710.LottieConstants.me.LayerType.TEXT)
			var $textLayer : cs:C1710.LottieTextLayer:=$layer
			$result.push({\
				layer: $textLayer.name; \
				text: $textLayer.text\
				})
		End if 
	End for each 
	return $result
	
	// Get file size estimate (JSON string length)
Function get fileSize() : Integer
	
	var $json : Text:=JSON Stringify:C1217(This:C1470.toJSON())
	return Length:C16($json)
	
	// Helper: trim whitespace
Function _trim($text : Text) : Text
	
	var $start : Integer:=1
	var $end : Integer:=Length:C16($text)
	
	While ($start<=$end) & (Position:C15($text[[$start]]; " \t\r\n")>0)
		$start:=$start+1
	End while 
	
	While ($end>=$start) & (Position:C15($text[[$end]]; " \t\r\n")>0)
		$end:=$end-1
	End while 
	
	If ($start>$end)
		return ""
	End if 
	
	return Substring:C12($text; $start; $end-$start+1)