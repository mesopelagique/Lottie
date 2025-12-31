//%attributes = {}
// test_Lottie_Ellipse
#DECLARE($stats : Object)

var $testName : Text
var $result : Boolean

LOG EVENT:C667($stats.output; "\n--- Test_Lottie_Ellipse ---\n"; Information message:K38:1)

// Test 1: fromJSON() is equal to toJSON()
$testName:="Ellipse fromJSON equals toJSON"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $shapeDef : Object:={\
		nm: "Ellipse"; \
		mn: "Ellipses"; \
		hd: False:C215; \
		d: 1; \
		ty: "el"; \
		s: {a: 0; k: [42; 42]; ix: 2}; \
		p: {a: 0; k: [0; 0]; ix: 3}\
		}
	
	var $ellipse : cs:C1710.LottieEllipse:=cs:C1710.LottieEllipse.new()
	$ellipse.fromJSON($shapeDef)
	
	var $output : Object:=$ellipse.toJSON()
	
	// Check key properties match
	If ($output.nm=$shapeDef.nm) & \
		($output.ty=$shapeDef.ty) & \
		($output.s.k[0]=$shapeDef.s.k[0]) & \
		($output.s.k[1]=$shapeDef.s.k[1]) & \
		($output.p.k[0]=$shapeDef.p.k[0]) & \
		($output.p.k[1]=$shapeDef.p.k[1])
		$result:=True:C214
	End if 
Catch
	$result:=False:C215
End try

_logTest($stats; $testName; $result)

// Test 2: Ellipse from loaded file
$testName:="Ellipse shape from loaded file"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $file : 4D:C1709.File:=Folder:C1567(fk resources folder:K87:11).file("tests/simple_ellipse.json")
	var $lottie : cs:C1710.Lottie:=cs:C1710.Lottie.new($file)
	
	// Get first layer (shape layer)
	var $layer : cs:C1710.LottieShapeLayer:=$lottie.layers[0]
	
	// Find ellipse shape
	var $shapes : Collection:=$layer.getShapesByType(cs:C1710.LottieConstants.me.ShapeType.ELLIPSE)
	
	If ($shapes.length=1)
		var $ellipse2 : cs:C1710.LottieEllipse:=$shapes[0]
		If ($ellipse2.name="Ellipse")
			$result:=True:C214
		End if 
	End if 
Catch
	$result:=False:C215
End try

_logTest($stats; $testName; $result)

// Test 3: Create ellipse programmatically
$testName:="Create ellipse programmatically"
$stats.total:=$stats.total+1
$result:=False:C215
Try
	var $ellipse3 : cs:C1710.LottieEllipse:=cs:C1710.LottieEllipse.new()
	$ellipse3.name:="My Ellipse"
	$ellipse3.size.staticValue:=[100; 50]
	$ellipse3.position.staticValue:=[25; 25]
	
	var $json : Object:=$ellipse3.toJSON()
	
	If ($json.nm="My Ellipse") & \
		($json.s.k[0]=100) & \
		($json.s.k[1]=50) & \
		($json.p.k[0]=25) & \
		($json.p.k[1]=25)
		$result:=True:C214
	End if 
Catch
	$result:=False:C215
End try

_logTest($stats; $testName; $result)
