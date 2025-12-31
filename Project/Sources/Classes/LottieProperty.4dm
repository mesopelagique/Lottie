property type : Text
property isAnimated : Boolean
property expression : Text
property index : Integer
property values : Collection
property _parent : Object

Class constructor($parent : Object; $type : Text)
	
	This._parent:=$parent
	This.type:=$type
	This.isAnimated:=False
	This.values:=[]

// Parse property from JSON
Function fromJSON($json : Object) : cs.LottieProperty
	
	// Expression (x)
	If ($json.x#Null)
		This.expression:=$json.x
	End if 
	
	// Index (ix)
	If ($json.ix#Null)
		This.index:=$json.ix
	End if 
	
	// Animated flag (a)
	This.isAnimated:=Bool($json.a)
	
	// Clear existing values before loading new ones
	This.values:=[]
	
	If (This.isAnimated)
		// Keyframe values (k is array of keyframes)
		If ($json.k#Null) & (Value type($json.k)=Is collection)
			var $kfJson : Object
			For each ($kfJson; $json.k)
				var $keyFrame : cs.LottieKeyFrame:=cs.LottieKeyFrame.new(0; Null)
				$keyFrame.fromJSON($kfJson)
				This.values.push($keyFrame)
			End for each 
		End if 
	Else 
		// Static value (k is the value directly)
		If ($json.k#Null)
			var $staticKeyFrame : cs.LottieKeyFrame:=cs.LottieKeyFrame.new(0; $json.k)
			This.values.push($staticKeyFrame)
		End if 
	End if 
	
	return This

// Serialize property to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	// Expression
	If (This.expression#Null) & (This.expression#"")
		$json.x:=This.expression
	End if 
	
	// Index
	If (This.index#Null)
		$json.ix:=This.index
	End if 
	
	// Animated
	$json.a:=This.isAnimated ? 1 : 0
	
	If (This.isAnimated)
		// Keyframe array
		$json.k:=[]
		var $kf : cs.LottieKeyFrame
		For each ($kf; This.values)
			$json.k.push($kf.toJSON())
		End for each 
	Else 
		// Static value
		If (This.values.length>0)
			$json.k:=This.values[0].value
		End if 
	End if 
	
	return $json

// Get value at specific frame
Function getValue($frame : Real) : Variant
	
	If (This.values.length=0)
		return Null
	End if 
	
	// Single keyframe or static value
	If (This.values.length=1)
		return This.values[0].value
	End if 
	
	// Find keyframes surrounding the frame
	var $prevKF : cs.LottieKeyFrame:=Null
	var $nextKF : cs.LottieKeyFrame:=Null
	var $kf : cs.LottieKeyFrame
	
	For each ($kf; This.values)
		If ($kf.frame<=$frame)
			$prevKF:=$kf
		Else 
			If ($nextKF=Null)
				$nextKF:=$kf
			End if 
		End if 
	End for each 
	
	// Before first keyframe
	If ($prevKF=Null)
		return This.values[0].value
	End if 
	
	// After last keyframe or no next keyframe
	If ($nextKF=Null)
		return $prevKF.value
	End if 
	
	// Interpolate between keyframes
	var $duration : Real:=$nextKF.frame-$prevKF.frame
	If ($duration<=0)
		return $prevKF.value
	End if 
	
	var $progress : Real:=($frame-$prevKF.frame)/$duration
	return $prevKF.interpolateTo($nextKF; $progress)

// Get value at specific time in seconds
Function getValueAtTime($time : Real; $frameRate : Real) : Variant
	
	var $frame : Real:=$time*$frameRate
	return This.getValue($frame)

// Get the static value (first keyframe value)
Function get staticValue() : Variant
	
	If (This.values.length>0)
		return This.values[0].value
	End if 
	return Null

// Set static value
Function set staticValue($value : Variant)
	
	This.isAnimated:=False
	This.values:=[cs.LottieKeyFrame.new(0; $value)]

// Add a keyframe
Function addKeyFrame($frame : Real; $value : Variant) : cs.LottieKeyFrame
	
	var $keyFrame : cs.LottieKeyFrame:=cs.LottieKeyFrame.new($frame; $value)
	
	// Insert in sorted order
	var $inserted : Boolean:=False
	var $i : Integer
	For ($i; 0; This.values.length-1)
		var $kf : cs.LottieKeyFrame:=This.values[$i]
		If ($frame<$kf.frame)
			This.values.insert($i; $keyFrame)
			$inserted:=True
			$i:=This.values.length  // Exit loop
		Else 
			If ($frame=$kf.frame)
				// Replace existing keyframe
				This.values[$i]:=$keyFrame
				$inserted:=True
				$i:=This.values.length  // Exit loop
			End if 
		End if 
	End for 
	
	If (Not($inserted))
		This.values.push($keyFrame)
	End if 
	
	This.isAnimated:=(This.values.length>1)
	
	return $keyFrame

// Remove keyframe at frame
Function removeKeyFrame($frame : Real) : Boolean
	
	var $i : Integer
	For ($i; 0; This.values.length-1)
		var $kf : cs.LottieKeyFrame:=This.values[$i]
		If ($kf.frame=$frame)
			This.values.remove($i)
			This.isAnimated:=(This.values.length>1)
			return True
		End if 
	End for 
	
	return False

// Get all keyframe frames
Function get frames() : Collection
	
	var $result : Collection:=[]
	var $kf : cs.LottieKeyFrame
	For each ($kf; This.values)
		$result.push($kf.frame)
	End for each 
	return $result

// Get min/max values across all keyframes
Function get valueRange() : Object
	
	var $min : Real:=0
	var $max : Real:=0
	var $first : Boolean:=True
	var $kf : cs.LottieKeyFrame
	
	For each ($kf; This.values)
		var $val : Variant:=$kf.value
		
		If (Value type($val)=Is collection)
			var $v : Variant
			For each ($v; $val)
				If ((Value type($v)=Is real) | (Value type($v)=Is longint))
					If ($first)
						$min:=$v
						$max:=$v
						$first:=False
					Else 
						$min:=($v<$min) ? $v : $min
						$max:=($v>$max) ? $v : $max
					End if 
				End if 
			End for each 
		Else 
			If ((Value type($val)=Is real) | (Value type($val)=Is longint))
				If ($first)
					$min:=$val
					$max:=$val
					$first:=False
				Else 
					$min:=($val<$min) ? $val : $min
					$max:=($val>$max) ? $val : $max
				End if 
			End if 
		End if 
	End for each 
	
	return {min: $min; max: $max}
