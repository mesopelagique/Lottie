//%attributes = {}
// test_Lottie_Path
#DECLARE($stats : Object)

var $testName : Text
var $result : Boolean

LOG EVENT:C667($stats.output; "\n--- Test_Lottie_Path ---\n"; Information message:K38:1)

// Test 1: fromJSON() is equal to toJSON()
$testName:="Path fromJSON equals toJSON"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $pathDef : Object:={\
		c: True:C214; \
		v: [[53; 325]; [429; 147]]; \
		i: [[0; 0]; [-147; 186]]; \
		o: [[89; -189]; [40; 189]]\
		}
	
	var $shapeDef : Object:={\
		nm: "Path"; \
		mn: "Path"; \
		hd: False:C215; \
		ty: "sh"; \
		ks: {a: 0; k: $pathDef}\
		}
	
	var $path : cs:C1710.LottiePath:=cs:C1710.LottiePath.new()
	$path.fromJSON($shapeDef)
	
	// Check vertices property contains the path data
	var $vertices : Variant:=$path.vertices.staticValue
	
	If ($vertices#Null:C1517)
		If ($vertices.c=True:C214) & ($vertices.v.length=2)
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

// Test 2: Path from loaded file
$testName:="Path shape from loaded file"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/path_shape.json")
	var $lottie : cs:C1710.Lottie:=cs:C1710.Lottie.new($file)
	
	// Get first layer (shape layer)
	var $layer : cs:C1710.LottieShapeLayer:=$lottie.layers[0]
	
	// Find path shape
	var $shapes : Collection:=$layer.getShapesByType(cs:C1710.LottieConstants.me.ShapeType.PATH)
	
	If ($shapes.length=1)
		var $path2 : cs:C1710.LottiePath:=$shapes[0]
		If ($path2.name="Path")
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

// Test 3: Path with stroke from file
$testName:="Path with stroke properties"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file2 : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/path_shape.json")
	var $lottie2 : cs:C1710.Lottie:=cs:C1710.Lottie.new($file2)
	
	var $layer2 : cs:C1710.LottieShapeLayer:=$lottie2.layers[0]
	var $strokes : Collection:=$layer2.getShapesByType(cs:C1710.LottieConstants.me.ShapeType.STROKE)
	
	If ($strokes.length=1)
		var $stroke : cs:C1710.LottieStroke:=$strokes[0]
		If ($stroke.width.staticValue=5)
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
