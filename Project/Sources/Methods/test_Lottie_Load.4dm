//%attributes = {}
// test_Lottie_Load
#DECLARE($stats : Object)

var $testName : Text
var $result : Boolean

LOG EVENT:C667($stats.output; "\n--- Test_Lottie_Load ---\n"; Information message:K38:1)

// Test 1: Load from file path
$testName:="Load from file path"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $resourcesPath : Text:=Folder:C1567(fk resources folder:K87:11).platformPath
	var $filePath : Text:=$resourcesPath+"tests"+Folder separator:K24:12+"simple_ellipse.json"
	var $lottie : cs:C1710.Lottie:=cs:C1710.Lottie.new($filePath)
	
	If ($lottie.version="5.7.4") & ($lottie.frameRate=30) & ($lottie.width=512)
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

// Test 2: Load from 4D.File object
$testName:="Load from 4D.File object"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/simple_ellipse.json")
	var $lottie2 : cs:C1710.Lottie:=cs:C1710.Lottie.new($file)
	
	If ($lottie2.name="Simple Ellipse Animation") & ($lottie2.layers.length=1)
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

// Test 3: Load from JSON text
$testName:="Load from JSON text"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $jsonText : Text:="{\"v\":\"5.0\",\"fr\":60,\"ip\":0,\"op\":120,\"w\":100,\"h\":100,\"layers\":[]}"
	var $lottie3 : cs:C1710.Lottie:=cs:C1710.Lottie.new($jsonText)
	
	If ($lottie3.version="5.0") & ($lottie3.frameRate=60) & ($lottie3.outPoint=120)
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

// Test 4: Load from JSON object
$testName:="Load from JSON object"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $jsonObj : Object:={v: "4.8"; fr: 25; ip: 0; op: 50; w: 200; h: 200; layers: []}
	var $lottie4 : cs:C1710.Lottie:=cs:C1710.Lottie.new($jsonObj)
	
	If ($lottie4.version="4.8") & ($lottie4.frameRate=25) & ($lottie4.width=200)
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

// Test 5: Invalid input should throw
$testName:="Invalid JSON throws error"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $lottie5 : cs:C1710.Lottie:=cs:C1710.Lottie.new("{invalid json}")
	// Should have thrown
	$result:=False:C215
Catch
	// Expected to throw
	$result:=True:C214
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
