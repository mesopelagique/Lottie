
singleton Class constructor
	var $schema:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("lottie.schema.json").getText())
	var $key : Text
	For each ($key; $schema)
		This:C1470[$key]:=$schema[$key]
	End for each 