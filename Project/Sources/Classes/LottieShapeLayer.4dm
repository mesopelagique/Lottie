property shapes : Collection

Class extends LottieLayer

Class constructor
	
	Super(cs.LottieConstants.me.LayerType.SHAPE)
	This.shapes:=[]

// Parse shape layer from JSON
Function fromJSON($json : Object) : cs.LottieShapeLayer
	
	// Parse base layer properties
	Super.fromJSON($json)
	
	// Shapes (shapes)
	If ($json.shapes#Null)
		var $shapeJson : Object
		For each ($shapeJson; $json.shapes)
			var $shape : cs.LottieShape:=cs.LottieShape.new("").createFromJSON($shapeJson; This)
			This.shapes.push($shape)
		End for each 
	End if 
	
	return This

// Serialize shape layer to JSON
Function toJSON() : Object
	
	var $json : Object:=Super.toJSON()
	
	If (This.shapes.length>0)
		$json.shapes:=[]
		var $shape : cs.LottieShape
		For each ($shape; This.shapes)
			$json.shapes.push($shape.toJSON())
		End for each 
	End if 
	
	return $json

// Get shapes by type
Function getShapesByType($type : Text) : Collection
	
	var $result : Collection:=[]
	This._collectShapesByType(This.shapes; $type; $result)
	return $result

// Recursive shape collection by type
Function _collectShapesByType($shapes : Collection; $type : Text; $result : Collection)
	
	var $shape : cs.LottieShape
	For each ($shape; $shapes)
		If ($shape.type=$type)
			$result.push($shape)
		End if 
		// Recurse into group shapes
		If ($shape.type=cs.LottieConstants.me.ShapeType.GROUP)
			var $group : cs.LottieShapeGroup:=$shape
			This._collectShapesByType($group.shapes; $type; $result)
		End if 
	End for each 

// Get all fill shapes
Function get fills() : Collection
	
	return This.getShapesByType(cs.LottieConstants.me.ShapeType.FILL)

// Get all stroke shapes
Function get strokes() : Collection
	
	return This.getShapesByType(cs.LottieConstants.me.ShapeType.STROKE)

// Get all path shapes
Function get paths() : Collection
	
	return This.getShapesByType(cs.LottieConstants.me.ShapeType.PATH)

// Get all ellipse shapes
Function get ellipses() : Collection
	
	return This.getShapesByType(cs.LottieConstants.me.ShapeType.ELLIPSE)

// Get all rectangle shapes
Function get rectangles() : Collection
	
	return This.getShapesByType(cs.LottieConstants.me.ShapeType.RECTANGLE)
