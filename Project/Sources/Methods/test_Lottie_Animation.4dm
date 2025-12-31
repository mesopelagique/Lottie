//%attributes = {}
// test_Lottie_Animation
#DECLARE($stats : Object)

var $testName : Text
var $result : Boolean

LOG EVENT:C667($stats.output; "\n--- Test_Lottie_Animation ---\n"; Information message:K38:1)

// Test 1: Load animation with keyframes
$testName:="Load animation with keyframes"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/animated_rectangle.json")
	var $lottie : cs:C1710.Lottie:=cs:C1710.Lottie.new($file)
	
	If ($lottie.frameRate=24) & ($lottie.outPoint=48) & ($lottie.width=400)
		$result:=True:C214
	End if 
Catch
	$result:=False:C215
End try

If ($result)
	$stats.passed:=$stats.passed+1
	LOG EVENT:C667($stats.output; "✅ "+$testName+"\n"; Information message:K38:1)
Else 
	$stats.failed:=$stats.failed+1
	LOG EVENT:C667($stats.output; "❌ "+$testName+"\n"; Information message:K38:1)
	If (Bool($stats.assert))
		ASSERT(False; "❌ "+$testName)
	End if 
End if 

// Test 2: Animated transform properties
$testName:="Animated transform properties"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file2 : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/animated_rectangle.json")
	var $lottie2 : cs:C1710.Lottie:=cs:C1710.Lottie.new($file2)
	
	var $layer : Object:=$lottie2.layers[0]
	var $transform : cs:C1710.LottieTransform:=$layer.transform
	
	// Rotation and scale should be animated
	If ($transform.rotation.isAnimated) & ($transform.scale.isAnimated)
		$result:=True:C214
	End if 
Catch
	$result:=False:C215
End try

If ($result)
	$stats.passed:=$stats.passed+1
	LOG EVENT:C667($stats.output; "✅ "+$testName+"\n"; Information message:K38:1)
Else 
	$stats.failed:=$stats.failed+1
	LOG EVENT:C667($stats.output; "❌ "+$testName+"\n"; Information message:K38:1)
	If (Bool($stats.assert))
		ASSERT(False; "❌ "+$testName)
	End if 
End if 

// Test 3: Markers
$testName:="Parse markers"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file3 : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/animated_rectangle.json")
	var $lottie3 : cs:C1710.Lottie:=cs:C1710.Lottie.new($file3)
	
	If ($lottie3.markers.length=2)
		var $marker1 : cs:C1710.LottieMarker:=$lottie3.markers[0]
		var $marker2 : cs:C1710.LottieMarker:=$lottie3.markers[1]
		
		If ($marker1.name="loop_start") & ($marker2.name="loop_end")
			$result:=True:C214
		End if 
	End if 
Catch
	$result:=False:C215
End try

If ($result)
	$stats.passed:=$stats.passed+1
	LOG EVENT:C667($stats.output; "✅ "+$testName+"\n"; Information message:K38:1)
Else 
	$stats.failed:=$stats.failed+1
	LOG EVENT:C667($stats.output; "❌ "+$testName+"\n"; Information message:K38:1)
	If (Bool($stats.assert))
		ASSERT(False; "❌ "+$testName)
	End if 
End if 

// Test 4: Duration calculation
$testName:="Duration calculation"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file4 : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/animated_rectangle.json")
	var $lottie4 : cs:C1710.Lottie:=cs:C1710.Lottie.new($file4)
	
	// Duration = (outPoint - inPoint) / frameRate = (48 - 0) / 24 = 2 seconds
	var $duration : Real:=$lottie4.duration
	
	If ($duration=2)
		$result:=True:C214
	End if 
Catch
	$result:=False:C215
End try

If ($result)
	$stats.passed:=$stats.passed+1
	LOG EVENT:C667($stats.output; "✅ "+$testName+"\n"; Information message:K38:1)
Else 
	$stats.failed:=$stats.failed+1
	LOG EVENT:C667($stats.output; "❌ "+$testName+"\n"; Information message:K38:1)
	If (Bool($stats.assert))
		ASSERT(False; "❌ "+$testName)
	End if 
End if 

// Test 5: Query layers by name
$testName:="Query layers by name"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file5 : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/simple_ellipse.json")
	var $lottie5 : cs:C1710.Lottie:=cs:C1710.Lottie.new($file5)
	
	var $found : cs.LottieLayer:=$lottie5.getLayerByName("Ellipse Layer")
	
	If ($found#Null)
		$result:=True:C214
	End if 
Catch
	$result:=False:C215
End try

If ($result)
	$stats.passed:=$stats.passed+1
	LOG EVENT:C667($stats.output; "✅ "+$testName+"\n"; Information message:K38:1)
Else 
	$stats.failed:=$stats.failed+1
	LOG EVENT:C667($stats.output; "❌ "+$testName+"\n"; Information message:K38:1)
	If (Bool($stats.assert))
		ASSERT(False; "❌ "+$testName)
	End if 
End if 
