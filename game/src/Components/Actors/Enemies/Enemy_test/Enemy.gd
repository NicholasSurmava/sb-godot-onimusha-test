extends KinematicBody2D

var HP = 10
var BLOOD_PATH = preload("res://src/Components/Blood/Blood.tscn")

var Timer_started = false

func _ready():
	randomize()

func on_Bullet_hit():
	var chance = rand_range(0, 100)
		
#	if chance > 90:
	var blood = BLOOD_PATH.instance()
	blood.global_position = global_position + Vector2(rand_range(-10, 10), rand_range(-10, 10))
	self.owner.add_child(blood)
			
	if HP > 0:
		HP -= 1
	else:
		if Timer_started == false:
			$Sprite.modulate =  Color( 0.6, 0.6, 0.6, 0.6 )
			$Timer.start()
			Timer_started = true
		
		
		


func _on_Timer_timeout():
	self.queue_free()
