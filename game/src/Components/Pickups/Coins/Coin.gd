extends Area2D



func _on_Coin_body_entered(body):
	if body.name == "Player":
		Autoload.SCORE += 20
		queue_free()
