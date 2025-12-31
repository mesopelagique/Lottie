property anchor : cs.LottieProperty
property position : cs.LottieProperty
property positionX : cs.LottieProperty
property positionY : cs.LottieProperty
property scale : cs.LottieProperty
property rotation : cs.LottieProperty
property rotationX : cs.LottieProperty
property rotationY : cs.LottieProperty
property rotationZ : cs.LottieProperty
property opacity : cs.LottieProperty
property skew : cs.LottieProperty
property skewAxis : cs.LottieProperty
property _parent : Object

Class constructor($parent : Object)
	
	var $const : cs.LottieConstants:=cs.LottieConstants.me
	
	This._parent:=$parent
	This.anchor:=cs.LottieProperty.new(This; $const.PropertyType.ANCHOR)
	This.position:=cs.LottieProperty.new(This; $const.PropertyType.POSITION)
	This.scale:=cs.LottieProperty.new(This; $const.PropertyType.SCALE)
	This.rotation:=cs.LottieProperty.new(This; $const.PropertyType.ROTATION)
	This.opacity:=cs.LottieProperty.new(This; $const.PropertyType.OPACITY)
	
	// Set default values
	This.anchor.staticValue:=[0; 0]
	This.position.staticValue:=[0; 0]
	This.scale.staticValue:=[100; 100]
	This.rotation.staticValue:=0
	This.opacity.staticValue:=100

// Parse transform from JSON
Function fromJSON($json : Object) : cs.LottieTransform
	
	// Anchor point (a)
	If ($json.a#Null)
		This.anchor.fromJSON($json.a)
	End if 
	
	// Position (p) - can be split into px/py
	If ($json.p#Null)
		This.position.fromJSON($json.p)
	End if 
	
	// Separate position X (px)
	If ($json.px#Null)
		var $const : cs.LottieConstants:=cs.LottieConstants.me
		This.positionX:=cs.LottieProperty.new(This; $const.PropertyType.POSITION)
		This.positionX.fromJSON($json.px)
	End if 
	
	// Separate position Y (py)
	If ($json.py#Null)
		var $const2 : cs.LottieConstants:=cs.LottieConstants.me
		This.positionY:=cs.LottieProperty.new(This; $const2.PropertyType.POSITION)
		This.positionY.fromJSON($json.py)
	End if 
	
	// Scale (s)
	If ($json.s#Null)
		This.scale.fromJSON($json.s)
	End if 
	
	// Rotation (r) or (rz for 3D)
	If ($json.r#Null)
		This.rotation.fromJSON($json.r)
	End if 
	If ($json.rz#Null)
		This.rotation.fromJSON($json.rz)
	End if 
	
	// 3D rotations
	If ($json.rx#Null)
		var $const3 : cs.LottieConstants:=cs.LottieConstants.me
		This.rotationX:=cs.LottieProperty.new(This; $const3.PropertyType.ROTATION)
		This.rotationX.fromJSON($json.rx)
	End if 
	If ($json.ry#Null)
		var $const4 : cs.LottieConstants:=cs.LottieConstants.me
		This.rotationY:=cs.LottieProperty.new(This; $const4.PropertyType.ROTATION)
		This.rotationY.fromJSON($json.ry)
	End if 
	
	// Opacity (o)
	If ($json.o#Null)
		This.opacity.fromJSON($json.o)
	End if 
	
	// Skew (sk)
	If ($json.sk#Null)
		var $const5 : cs.LottieConstants:=cs.LottieConstants.me
		This.skew:=cs.LottieProperty.new(This; $const5.PropertyType.SKEW)
		This.skew.fromJSON($json.sk)
	End if 
	
	// Skew Axis (sa)
	If ($json.sa#Null)
		var $const6 : cs.LottieConstants:=cs.LottieConstants.me
		This.skewAxis:=cs.LottieProperty.new(This; $const6.PropertyType.SKEW_AXIS)
		This.skewAxis.fromJSON($json.sa)
	End if 
	
	return This

// Serialize transform to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	// Anchor point
	$json.a:=This.anchor.toJSON()
	
	// Position - check if split
	If (This.positionX#Null) & (This.positionY#Null)
		$json.px:=This.positionX.toJSON()
		$json.py:=This.positionY.toJSON()
	Else 
		$json.p:=This.position.toJSON()
	End if 
	
	// Scale
	$json.s:=This.scale.toJSON()
	
	// Rotation - check for 3D
	If (This.rotationX#Null) | (This.rotationY#Null)
		If (This.rotationX#Null)
			$json.rx:=This.rotationX.toJSON()
		End if 
		If (This.rotationY#Null)
			$json.ry:=This.rotationY.toJSON()
		End if 
		$json.rz:=This.rotation.toJSON()
	Else 
		$json.r:=This.rotation.toJSON()
	End if 
	
	// Opacity
	$json.o:=This.opacity.toJSON()
	
	// Skew
	If (This.skew#Null)
		$json.sk:=This.skew.toJSON()
	End if 
	
	// Skew Axis
	If (This.skewAxis#Null)
		$json.sa:=This.skewAxis.toJSON()
	End if 
	
	return $json

// Get position at frame
Function getPosition($frame : Real) : Collection
	
	If (This.positionX#Null) & (This.positionY#Null)
		return [This.positionX.getValue($frame); This.positionY.getValue($frame)]
	Else 
		return This.position.getValue($frame)
	End if 

// Get scale at frame
Function getScale($frame : Real) : Collection
	
	return This.scale.getValue($frame)

// Get rotation at frame
Function getRotation($frame : Real) : Real
	
	return This.rotation.getValue($frame)

// Get opacity at frame (0-100)
Function getOpacity($frame : Real) : Real
	
	return This.opacity.getValue($frame)

// Get anchor point at frame
Function getAnchor($frame : Real) : Collection
	
	return This.anchor.getValue($frame)
