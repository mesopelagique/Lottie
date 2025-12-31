property stops : Collection
property colorCount : Integer

Class constructor
	
	This.stops:=[]
	This.colorCount:=0

// Parse gradient from array
// Format: [offset1, r1, g1, b1, offset2, r2, g2, b2, ...]
Function fromArray($data : Collection; $colorCount : Integer) : cs.LottieGradient
	
	This.colorCount:=$colorCount
	This.stops:=[]
	
	var $i : Integer:=0
	While ($i<$data.length) & ((This.stops.length/4)<$colorCount)
		var $offset : Real:=$data[$i]
		var $r : Real:=$data[$i+1]
		var $g : Real:=$data[$i+2]
		var $b : Real:=$data[$i+3]
		
		This.stops.push({ \
			offset: $offset; \
			color: [$r; $g; $b] \
			})
		
		$i:=$i+4
	End while 
	
	return This

// Serialize gradient to array
Function toArray() : Collection
	
	var $result : Collection:=[]
	var $stop : Object
	
	For each ($stop; This.stops)
		$result.push($stop.offset)
		$result.push($stop.color[0])
		$result.push($stop.color[1])
		$result.push($stop.color[2])
	End for each 
	
	return $result

// Add gradient stop
Function addStop($offset : Real; $r : Real; $g : Real; $b : Real) : Object
	
	var $stop : Object:={ \
		offset: $offset; \
		color: [$r; $g; $b] \
		}
	
	// Insert in sorted order by offset
	var $inserted : Boolean:=False
	var $i : Integer
	For ($i; 0; This.stops.length-1)
		If ($offset<This.stops[$i].offset)
			This.stops.insert($i; $stop)
			$inserted:=True
			$i:=This.stops.length  // Exit loop
		End if 
	End for 
	
	If (Not($inserted))
		This.stops.push($stop)
	End if 
	
	This.colorCount:=This.stops.length
	
	return $stop

// Get color at offset (0-1)
Function getColorAtOffset($offset : Real) : Collection
	
	If (This.stops.length=0)
		return [0; 0; 0]
	End if 
	
	If (This.stops.length=1)
		return This.stops[0].color
	End if 
	
	// Find surrounding stops
	var $prevStop : Object:=Null
	var $nextStop : Object:=Null
	var $stop : Object
	
	For each ($stop; This.stops)
		If ($stop.offset<=$offset)
			$prevStop:=$stop
		Else 
			If ($nextStop=Null)
				$nextStop:=$stop
			End if 
		End if 
	End for each 
	
	If ($prevStop=Null)
		return This.stops[0].color
	End if 
	
	If ($nextStop=Null)
		return $prevStop.color
	End if 
	
	// Interpolate
	var $range : Real:=$nextStop.offset-$prevStop.offset
	If ($range<=0)
		return $prevStop.color
	End if 
	
	var $t : Real:=($offset-$prevStop.offset)/$range
	
	return [ \
		$prevStop.color[0]+(($nextStop.color[0]-$prevStop.color[0])*$t); \
		$prevStop.color[1]+(($nextStop.color[1]-$prevStop.color[1])*$t); \
		$prevStop.color[2]+(($nextStop.color[2]-$prevStop.color[2])*$t) \
		]
