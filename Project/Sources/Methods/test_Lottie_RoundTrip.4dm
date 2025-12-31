//%attributes = {}
// test_Lottie_RoundTrip
#DECLARE($stats : Object)

var $testName : Text
var $result : Boolean

LOG EVENT:C667($stats.output; "\n--- Test_Lottie_RoundTrip ---\n"; Information message:K38:1)

// Test 1: Simple ellipse round-trip
$testName:="Simple ellipse round-trip"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/simple_ellipse.json")
	var $lottie1 : cs:C1710.Lottie:=cs:C1710.Lottie.new($file)
	
	// Convert to JSON
	var $json : Object:=$lottie1.toJSON()
	
	// Load from that JSON
	var $lottie2 : cs:C1710.Lottie:=cs:C1710.Lottie.new($json)
	
	// Compare key properties
	If ($lottie1.version=$lottie2.version) & \
		($lottie1.frameRate=$lottie2.frameRate) & \
		($lottie1.width=$lottie2.width) & \
		($lottie1.height=$lottie2.height) & \
		($lottie1.inPoint=$lottie2.inPoint) & \
		($lottie1.outPoint=$lottie2.outPoint) & \
		($lottie1.layers.length=$lottie2.layers.length)
		$result:=True:C214
	End if 
Catch
	$result:=False:C215
End try

_logTest($stats; $testName; $result)

// Test 2: Animated rectangle round-trip
$testName:="Animated rectangle round-trip"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file2 : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/animated_rectangle.json")
	var $lottie3 : cs:C1710.Lottie:=cs:C1710.Lottie.new($file2)
	
	var $json2 : Object:=$lottie3.toJSON()
	var $lottie4 : cs:C1710.Lottie:=cs:C1710.Lottie.new($json2)
	
	// Check markers survived round-trip
	If ($lottie3.markers.length=$lottie4.markers.length)
		If ($lottie4.markers.length>0)
			var $m1 : cs:C1710.LottieMarker:=$lottie3.markers[0]
			var $m2 : cs:C1710.LottieMarker:=$lottie4.markers[0]
			If ($m1.name=$m2.name)
				$result:=True:C214
			End if 
		End if 
	End if 
Catch
	$result:=False:C215
End try

_logTest($stats; $testName; $result)

// Test 3: Save and reload
$testName:="Save to temp file and reload"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file3 : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/simple_ellipse.json")
	var $lottie5 : cs:C1710.Lottie:=cs:C1710.Lottie.new($file3)
	
	// Modify something
	$lottie5.name:="Modified Animation"
	
	// Save to temp file
	var $tempFile : 4D:C1709.File:=Folder:C1567(Temporary folder:C486; fk platform path:K87:2).file("test_lottie_save.json")
	$lottie5.save($tempFile)
	
	// Reload
	var $lottie6 : cs:C1710.Lottie:=cs:C1710.Lottie.new($tempFile)
	
	If ($lottie6.name="Modified Animation")
		$result:=True:C214
	End if 
	
	// Clean up
	$tempFile.delete()
Catch
	$result:=False:C215
End try

_logTest($stats; $testName; $result)

// Test 4: Create animation from scratch
$testName:="Create animation from scratch"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	// Create minimal valid JSON
	var $json3 : Object:={\
		v: "5.7.4"; \
		fr: 30; \
		ip: 0; \
		op: 60; \
		w: 100; \
		h: 100; \
		nm: "Created Animation"; \
		layers: []\
		}
	
	var $lottie7 : cs:C1710.Lottie:=cs:C1710.Lottie.new($json3)
	
	// Export and reload
	var $exported : Object:=$lottie7.toJSON()
	var $lottie8 : cs:C1710.Lottie:=cs:C1710.Lottie.new($exported)
	
	If ($lottie8.name="Created Animation") & ($lottie8.duration=2)
		$result:=True:C214
	End if 
Catch
	$result:=False:C215
End try

_logTest($stats; $testName; $result)
