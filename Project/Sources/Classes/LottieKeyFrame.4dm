property frame : Real
property value : Variant
property frameInTangent : Collection
property frameOutTangent : Collection
property valueInTangent : Collection
property valueOutTangent : Collection
property hold : Boolean

Class constructor($frame : Real; $value : Variant)
	
	This.frame:=$frame
	This.value:=$value
	This.hold:=False

// Parse keyframe from JSON
Function fromJSON($json : Object) : cs.LottieKeyFrame
	
	// Frame time (t)
	If ($json.t#Null)
		This.frame:=$json.t
	End if 
	
	// Start value (s) - can be array or single value
	If ($json.s#Null)
		If (Value type($json.s)=Is collection)
			var $s : Collection:=$json.s
			If ($s.length=1)
				This.value:=$s[0]
			Else 
				This.value:=$s
			End if 
		Else 
			This.value:=$json.s
		End if 
	End if 
	
	// Hold keyframe (h)
	This.hold:=Bool($json.h)
	
	// Bezier easing - output tangent (o)
	If ($json.o#Null)
		If ($json.o.x#Null) & ($json.o.y#Null)
			This.frameOutTangent:=This._normalizeEasing($json.o.x)
			This.valueOutTangent:=This._normalizeEasing($json.o.y)
		End if 
	End if 
	
	// Bezier easing - input tangent (i)
	If ($json.i#Null)
		If ($json.i.x#Null) & ($json.i.y#Null)
			This.frameInTangent:=This._normalizeEasing($json.i.x)
			This.valueInTangent:=This._normalizeEasing($json.i.y)
		End if 
	End if 
	
	return This

// Normalize easing value to collection
Function _normalizeEasing($val : Variant) : Collection
	
	If (Value type($val)=Is collection)
		return $val
	Else 
		return [$val]
	End if 

// Serialize keyframe to JSON
Function toJSON() : Object
	
	var $json : Object:={}
	
	$json.t:=This.frame
	
	// Value as array
	If (Value type(This.value)=Is collection)
		$json.s:=This.value
	Else 
		$json.s:=[This.value]
	End if 
	
	// Hold
	If (This.hold)
		$json.h:=1
	End if 
	
	// Easing tangents
	If (This.frameOutTangent#Null) & (This.valueOutTangent#Null)
		$json.o:={x: This.frameOutTangent; y: This.valueOutTangent}
	End if 
	
	If (This.frameInTangent#Null) & (This.valueInTangent#Null)
		$json.i:={x: This.frameInTangent; y: This.valueInTangent}
	End if 
	
	return $json

// Interpolate to next keyframe at given progress (0-1)
Function interpolateTo($nextKeyFrame : cs.LottieKeyFrame; $progress : Real) : Variant
	
	// Hold keyframe - no interpolation
	If (This.hold)
		return This.value
	End if 
	
	// Apply bezier easing if tangents exist
	var $easedProgress : Real:=$progress
	If (This.frameOutTangent#Null) & ($nextKeyFrame.frameInTangent#Null)
		$easedProgress:=This._cubicBezier($progress; \
			This.frameOutTangent[0]; This.valueOutTangent[0]; \
			$nextKeyFrame.frameInTangent[0]; $nextKeyFrame.valueInTangent[0])
	End if 
	
	// Interpolate based on value type
	return This._interpolateValue(This.value; $nextKeyFrame.value; $easedProgress)

// Cubic bezier calculation for easing
Function _cubicBezier($t : Real; $x1 : Real; $y1 : Real; $x2 : Real; $y2 : Real) : Real
	
	// Newton-Raphson iteration to find t for given x
	var $guess : Real:=$t
	var $i : Integer
	
	For ($i; 1; 10)
		var $currentX : Real:=This._bezierPoint($guess; $x1; $x2)
		var $currentSlope : Real:=This._bezierSlope($guess; $x1; $x2)
		
		If (Abs($currentSlope)<0.0001)
			$i:=11  // Exit loop
		Else 
			$guess:=$guess-(($currentX-$t)/$currentSlope)
		End if 
	End for 
	
	// Return y value at solved t
	return This._bezierPoint($guess; $y1; $y2)

// Bezier point calculation
Function _bezierPoint($t : Real; $p1 : Real; $p2 : Real) : Real
	
	var $invT : Real:=1-$t
	return (3*$invT*$invT*$t*$p1)+(3*$invT*$t*$t*$p2)+($t*$t*$t)

// Bezier slope calculation
Function _bezierSlope($t : Real; $p1 : Real; $p2 : Real) : Real
	
	var $invT : Real:=1-$t
	return (3*$invT*$invT*$p1)+(6*$invT*$t*($p2-$p1))+(3*$t*$t*(1-$p2))

// Interpolate between two values
Function _interpolateValue($from : Variant; $to : Variant; $progress : Real) : Variant
	
	var $fromType : Integer:=Value type($from)
	var $toType : Integer:=Value type($to)
	
	// Both are numbers
	If (($fromType=Is real) | ($fromType=Is longint)) & (($toType=Is real) | ($toType=Is longint))
		return $from+(($to-$from)*$progress)
	End if 
	
	// Both are collections (arrays)
	If ($fromType=Is collection) & ($toType=Is collection)
		var $fromColl : Collection:=$from
		var $toColl : Collection:=$to
		var $result : Collection:=[]
		var $i : Integer
		var $maxIndex : Integer:=($fromColl.length<$toColl.length) ? $fromColl.length : $toColl.length
		
		For ($i; 0; $maxIndex-1)
			var $fromVal : Variant:=$fromColl[$i]
			var $toVal : Variant:=$toColl[$i]
			
			If ((Value type($fromVal)=Is real) | (Value type($fromVal)=Is longint)) & \
				((Value type($toVal)=Is real) | (Value type($toVal)=Is longint))
				$result.push($fromVal+(($toVal-$fromVal)*$progress))
			Else 
				$result.push($fromVal)
			End if 
		End for 
		
		return $result
	End if 
	
	// Default: return from value
	return $from
