//%attributes = {}
// _logTest
// Private helper method to log test results
#DECLARE($stats : Object; $testName : Text; $result : Boolean)

If ($result)
	$stats.passed+=1
	LOG EVENT:C667($stats.output=Null:C1517 ? Into system standard outputs:K38:9 : $stats.output; "✅ "+$testName+"\n"; Information message:K38:1)
Else 
	$stats.failed+=1
	LOG EVENT:C667($stats.output=Null:C1517 ? Into system standard outputs:K38:9 : $stats.output; "❌ "+$testName+"\n"; Error message:K38:3)
	If (Bool:C1537($stats.assert))
		ASSERT:C1129(False:C215; "❌ "+$testName)
	End if 
End if 
