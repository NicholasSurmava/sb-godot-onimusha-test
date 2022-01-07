extends Control

func _process(delta):
	$Label.text = str(Autoload.SCORE)
	$Label3.text = "BLOOD = " + str(Autoload.BLOOD_LEVEL)
