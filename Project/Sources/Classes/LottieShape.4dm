property type : Text
property name : Text
property matchName : Text
property isHidden : Boolean
property itemIndex : Integer
property shapeIndex : Integer
property classNames : Text
property direction : Integer
property _parent : Object

Class constructor($type : Text)
	
	This:C1470.type:=$type
	This:C1470.name:=""
	This:C1470.isHidden:=False:C215
	This:C1470.direction:=1
	
	// Factory: create shape from JSON
Function createFromJSON($json : Object; $parent : Object) : cs:C1710.LottieShape
	
	var $const : cs:C1710.LottieConstants:=cs:C1710.LottieConstants.me
	var $type : Text:=$json.ty
	var $shape : cs:C1710.LottieShape
	
	Case of 
		: ($type=$const.ShapeType.ELLIPSE)
			$shape:=cs:C1710.LottieEllipse.new()
		: ($type=$const.ShapeType.RECTANGLE)
			$shape:=cs:C1710.LottieRectangle.new()
		: ($type=$const.ShapeType.PATH)
			$shape:=cs:C1710.LottiePath.new()
		: ($type=$const.ShapeType.STAR)
			$shape:=cs:C1710.LottieStar.new()
		: ($type=$const.ShapeType.FILL)
			$shape:=cs:C1710.LottieFill.new()
		: ($type=$const.ShapeType.STROKE)
			$shape:=cs:C1710.LottieStroke.new()
		: ($type=$const.ShapeType.GRADIENT_FILL)
			$shape:=cs:C1710.LottieGradientFill.new()
		: ($type=$const.ShapeType.GRADIENT_STROKE)
			$shape:=cs:C1710.LottieGradientStroke.new()
		: ($type=$const.ShapeType.GROUP)
			$shape:=cs:C1710.LottieShapeGroup.new()
		: ($type=$const.ShapeType.TRIM)
			$shape:=cs:C1710.LottieTrim.new()
		: ($type=$const.ShapeType.REPEATER)
			$shape:=cs:C1710.LottieRepeater.new()
		: ($type=$const.ShapeType.MERGE)
			$shape:=cs:C1710.LottieMerge.new()
		: ($type=$const.ShapeType.ROUNDED_CORNERS)
			$shape:=cs:C1710.LottieRoundedCorners.new()
		: ($type=$const.ShapeType.OFFSET_PATH)
			$shape:=cs:C1710.LottieOffsetPath.new()
		: ($type=$const.ShapeType.PUCKER_BLOAT)
			$shape:=cs:C1710.LottiePuckerBloat.new()
		: ($type=$const.ShapeType.TWIST)
			$shape:=cs:C1710.LottieTwist.new()
		Else 
			$shape:=cs:C1710.LottieShape.new($type)
	End case 
	
	$shape._parent:=$parent
	$shape.fromJSON($json)
	
	return $shape
	
	// Parse base shape properties from JSON
Function fromJSON($json : Object) : cs:C1710.LottieShape
	
	// Type (ty)
	If ($json.ty#Null:C1517)
		This:C1470.type:=$json.ty
	End if 
	
	// Name (nm)
	If ($json.nm#Null:C1517)
		This:C1470.name:=$json.nm
	End if 
	
	// Match name (mn)
	If ($json.mn#Null:C1517)
		This:C1470.matchName:=$json.mn
	End if 
	
	// Hidden (hd)
	This:C1470.isHidden:=Bool:C1537($json.hd)
	
	// Item index (ix)
	If ($json.ix#Null:C1517)
		This:C1470.itemIndex:=$json.ix
	End if 
	
	// Shape index (cix)
	If ($json.cix#Null:C1517)
		This:C1470.shapeIndex:=$json.cix
	End if 
	
	// Class names (cl)
	If ($json.cl#Null:C1517)
		This:C1470.classNames:=$json.cl
	End if 
	
	// Direction (d)
	If ($json.d#Null:C1517)
		This:C1470.direction:=$json.d
	End if 
	
	return This:C1470
	
	// Serialize base shape properties to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	$json.ty:=This:C1470.type
	
	If (This:C1470.name#Null:C1517) & (This:C1470.name#"")
		$json.nm:=This:C1470.name
	End if 
	
	If (This:C1470.matchName#Null:C1517) & (This:C1470.matchName#"")
		$json.mn:=This:C1470.matchName
	End if 
	
	If (This:C1470.isHidden)
		$json.hd:=True:C214
	End if 
	
	If (This:C1470.itemIndex#Null:C1517)
		$json.ix:=This:C1470.itemIndex
	End if 
	
	If (This:C1470.shapeIndex#Null:C1517)
		$json.cix:=This:C1470.shapeIndex
	End if 
	
	If (This:C1470.classNames#Null:C1517) & (This:C1470.classNames#"")
		$json.cl:=This:C1470.classNames
	End if 
	
	If (This:C1470.direction#1)
		$json.d:=This:C1470.direction
	End if 
	
	return $json
	
	// Get type name
Function get typeName() : Text
	
	return cs:C1710.LottieConstants.me.getShapeTypeName(This:C1470.type)
	