//%attributes = {}
// test_Lottie_Schema
// Validates all test JSON files against the Lottie schema
#DECLARE($stats : Object)

var $testName : Text
var $result : Boolean

LOG EVENT:C667($stats.output; "\n--- Test_Lottie_Schema ---\n"; Information message:K38:1)

// Get the schema singleton
var $schema : cs:C1710.LottieSchema:=cs:C1710.LottieSchema.me

// Get all test JSON files
var $testsFolder : 4D:C1709.Folder:=Folder:C1567(fk resources folder:K87:11).folder("tests")
var $testFiles : Collection:=$testsFolder.files(fk ignore invisible:K87:22).query("extension = :1"; ".json")

// Validate each test file against the schema
var $file : 4D:C1709.File
For each ($file; $testFiles)
	$testName:="Schema validation: "+$file.name
	$stats.total:=$stats.total+1
	$result:=False:C215
	
	Try
		var $json : Object:=JSON Parse:C1218($file.getText())
		var $validation : Object:=JSON Validate:C1456($json; $schema)
		
		If ($validation.success)
			$result:=True:C214
		Else 
			// Log validation errors for debugging
			LOG EVENT:C667($stats.output; "  Validation errors for "+$file.name+":\n"; Information message:K38:1)
			var $error : Object
			For each ($error; $validation.errors)
				LOG EVENT:C667($stats.output; "    - "+$error.message+" at "+$error.jsonPath+"\n"; Information message:K38:1)
			End for each 
		End if 
	Catch
		LOG EVENT:C667($stats.output; "  Error parsing "+$file.name+": "+Last errors:C1799[0].message+"\n"; Information message:K38:1)
		$result:=False:C215
	End try
	
	_logTest($stats; $testName; $result)
	
	// Test round-trip: Load file into Lottie, export with toJSON(), validate against schema
	$testName:="Schema validation (toJSON): "+$file.name
	$stats.total:=$stats.total+1
	$result:=False:C215
	
	Try
		var $lottie : cs:C1710.Lottie:=cs:C1710.Lottie.new($file)
		var $exportedJson : Object:=$lottie.toJSON()
		var $validation2 : Object:=JSON Validate:C1456($exportedJson; $schema)
		
		If ($validation2.success)
			$result:=True:C214
		Else 
			// Log validation errors for debugging
			LOG EVENT:C667($stats.output; "  Validation errors for toJSON of "+$file.name+":\n"; Information message:K38:1)
			var $error2 : Object
			For each ($error2; $validation2.errors)
				LOG EVENT:C667($stats.output; "    - "+$error2.message+" at "+$error2.jsonPath+"\n"; Information message:K38:1)
			End for each 
		End if 
	Catch
		LOG EVENT:C667($stats.output; "  Error with toJSON for "+$file.name+": "+Last errors:C1799[0].message+"\n"; Information message:K38:1)
		$result:=False:C215
	End try
	
	_logTest($stats; $testName; $result)
End for each 
