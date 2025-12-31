//%attributes = {}
// test_Lottie
// Main test runner for Lottie classes
// Run with: tool4d --project Project/Lottie.4DProject --dataless --skip-onstartup --startup-method test_Lottie

var $stats:={passed: 0; failed: 0; total: 0; output: Into system standard outputs:K38:9; assert: True:C214}

var $ui:=True:C214  // TODO: check if CLI
// Run all test suites

test_Lottie_Load($stats)
test_Lottie_Ellipse($stats)
test_Lottie_Path($stats)
test_Lottie_Animation($stats)
test_Lottie_RoundTrip($stats)

// Print summary
var $summary : Text
$summary:="\n========================================\n"
$summary+="TEST SUMMARY\n"
$summary+="========================================\n"
$summary+="Total:  "+String:C10($stats.total)+"\n"
$summary+="Passed: "+String:C10($stats.passed)+"\n"
$summary+="Failed: "+String:C10($stats.failed)+"\n"
$summary+="========================================\n"

If ($stats.failed=0)
	$summary+="✅ ALL TESTS PASSED\n"
Else 
	$summary+="❌ SOME TESTS FAILED\n"
End if 
If ($ui)
	ALERT:C41($summary)
End if 
LOG EVENT:C667(Into system standard outputs:K38:9; $summary; Information message:K38:1)

If (Not:C34($ui))
	If ($stats.failed>0)
		// TODO: Exit with appropriate code...
	End if 
	QUIT 4D:C291(0)
End if 
