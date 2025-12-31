property type : Integer
property name : Text
property index : Integer
property id : Text
property inPoint : Real
property outPoint : Real
property startTime : Real
property timeStretch : Real
property blendMode : Integer
property is3D : Boolean
property isHidden : Boolean
property autoOrient : Boolean
property matteMode : Integer
property matteTarget : Integer
property parentIndex : Integer
property classNames : Collection
property matchName : Text
property transform : cs.LottieTransform
property masks : Collection
property effects : Collection
property _parent : Object

Class constructor($type : Integer)
	
	This.type:=$type
	This.name:=""
	This.inPoint:=0
	This.outPoint:=0
	This.startTime:=0
	This.timeStretch:=1
	This.blendMode:=cs.LottieConstants.me.BlendMode.NORMAL
	This.is3D:=False
	This.isHidden:=False
	This.autoOrient:=False
	This.classNames:=[]
	This.masks:=[]
	This.effects:=[]
	This.transform:=cs.LottieTransform.new(This)

// Factory: create layer from JSON
Function createFromJSON($json : Object; $parent : Object) : cs.LottieLayer
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	var $type : Integer:=$json.ty
	var $layer : cs.LottieLayer
	
	Case of 
		: ($type=$const.LayerType.SHAPE)
			$layer:=cs.LottieShapeLayer.new()
		: ($type=$const.LayerType.TEXT)
			$layer:=cs.LottieTextLayer.new()
		: ($type=$const.LayerType.IMAGE)
			$layer:=cs.LottieImageLayer.new()
		: ($type=$const.LayerType.PRECOMP)
			$layer:=cs.LottiePrecompLayer.new()
		: ($type=$const.LayerType.SOLID)
			$layer:=cs.LottieSolidLayer.new()
		: ($type=$const.LayerType.GROUP)
			$layer:=cs.LottieGroupLayer.new()
		Else 
			$layer:=cs.LottieLayer.new($type)
	End case 
	
	$layer._parent:=$parent
	$layer.fromJSON($json)
	
	return $layer

// Parse base layer properties from JSON
Function fromJSON($json : Object) : cs.LottieLayer
	
	// Type (ty)
	If ($json.ty#Null)
		This.type:=$json.ty
	End if 
	
	// Name (nm)
	If ($json.nm#Null)
		This.name:=$json.nm
	End if 
	
	// Index (ind)
	If ($json.ind#Null)
		This.index:=$json.ind
	End if 
	
	// Id (ln)
	If ($json.ln#Null)
		This.id:=$json.ln
	End if 
	
	// In point (ip)
	If ($json.ip#Null)
		This.inPoint:=$json.ip
	End if 
	
	// Out point (op)
	If ($json.op#Null)
		This.outPoint:=$json.op
	End if 
	
	// Start time (st)
	If ($json.st#Null)
		This.startTime:=$json.st
	End if 
	
	// Time stretch (sr)
	If ($json.sr#Null)
		This.timeStretch:=$json.sr
	End if 
	
	// Blend mode (bm)
	If ($json.bm#Null)
		This.blendMode:=$json.bm
	End if 
	
	// 3D layer (ddd)
	This.is3D:=Bool($json.ddd)
	
	// Hidden (hd)
	This.isHidden:=Bool($json.hd)
	
	// Auto-orient (ao)
	This.autoOrient:=Bool($json.ao)
	
	// Matte mode (tt)
	If ($json.tt#Null)
		This.matteMode:=$json.tt
	End if 
	
	// Matte target (td)
	If ($json.td#Null)
		This.matteTarget:=$json.td
	End if 
	
	// Parent index (parent)
	If ($json.parent#Null)
		This.parentIndex:=$json.parent
	End if 
	
	// Class names (cl)
	If ($json.cl#Null)
		If (Value type($json.cl)=Is text)
			This.classNames:=Split string($json.cl; " ")
		Else 
			This.classNames:=$json.cl
		End if 
	End if 
	
	// Match name (mn)
	If ($json.mn#Null)
		This.matchName:=$json.mn
	End if 
	
	// Transform (ks)
	If ($json.ks#Null)
		This.transform.fromJSON($json.ks)
	End if 
	
	// Masks (masksProperties)
	If ($json.masksProperties#Null)
		var $maskJson : Object
		For each ($maskJson; $json.masksProperties)
			var $mask : cs.LottieMask:=cs.LottieMask.new(This)
			$mask.fromJSON($maskJson)
			This.masks.push($mask)
		End for each 
	End if 
	
	// Effects (ef)
	If ($json.ef#Null)
		var $effectJson : Object
		For each ($effectJson; $json.ef)
			var $effect : cs.LottieEffect:=cs.LottieEffect.new(This)
			$effect.fromJSON($effectJson)
			This.effects.push($effect)
		End for each 
	End if 
	
	return This

// Serialize base layer properties to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	$json.ty:=This.type
	
	If (This.name#"")
		$json.nm:=This.name
	End if 
	
	If (This.index#Null)
		$json.ind:=This.index
	End if 
	
	If (This.id#Null) & (This.id#"")
		$json.ln:=This.id
	End if 
	
	$json.ip:=This.inPoint
	$json.op:=This.outPoint
	$json.st:=This.startTime
	
	If (This.timeStretch#1)
		$json.sr:=This.timeStretch
	End if 
	
	If (This.blendMode#0)
		$json.bm:=This.blendMode
	End if 
	
	If (This.is3D)
		$json.ddd:=1
	End if 
	
	If (This.isHidden)
		$json.hd:=True
	End if 
	
	If (This.autoOrient)
		$json.ao:=1
	End if 
	
	If (This.matteMode#Null)
		$json.tt:=This.matteMode
	End if 
	
	If (This.matteTarget#Null)
		$json.td:=This.matteTarget
	End if 
	
	If (This.parentIndex#Null)
		$json.parent:=This.parentIndex
	End if 
	
	If (This.classNames.length>0)
		$json.cl:=This.classNames.join(" ")
	End if 
	
	If (This.matchName#Null) & (This.matchName#"")
		$json.mn:=This.matchName
	End if 
	
	$json.ks:=This.transform.toJSON()
	
	If (This.masks.length>0)
		$json.masksProperties:=[]
		var $mask : cs.LottieMask
		For each ($mask; This.masks)
			$json.masksProperties.push($mask.toJSON())
		End for each 
	End if 
	
	If (This.effects.length>0)
		$json.ef:=[]
		var $effect : cs.LottieEffect
		For each ($effect; This.effects)
			$json.ef.push($effect.toJSON())
		End for each 
	End if 
	
	return $json

// Get type name
Function get typeName() : Text
	
	return cs.LottieConstants.me.getLayerTypeName(This.type)

// Get duration in frames
Function get duration() : Real
	
	return This.outPoint-This.inPoint
