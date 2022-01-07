extends KinematicBody2D

var speed = 100
onready var move_to = Autoload.Player.global_position
var MOVE = false
var ABSORB = false
onready var Timer = $Timer

func _ready():
	Timer.wait_time = 40
	Timer.start()
	Autoload.Player.connect('absorbing_blood', self, "_on_Player_absorbing_blood")
	Autoload.Player.connect('stop_absorbing_blood', self, "_on_Player_stop_absorbing_blood")
	print(move_to)
	
func _process(delta):
	if Timer.time_left == 7:
		$ColorRect.color = Color(1, 1, 1, 0.7)
		$Line2D.default_color = Color(1, 1, 1, 0.7)
	if Timer.time_left == 4:
		$ColorRect.color = Color(1, 1, 1, 0.4)
		$Line2D.default_color = Color(1, 1, 1, 0.4)
	if Timer.time_left == 1:
		$ColorRect.color = Color(1, 1, 1, 0.1)
		$Line2D.default_color = Color(1, 1, 1, 0.1)
	
func _physics_process(delta):
	if MOVE == true:
		if ABSORB == true:
			move_to = Autoload.Player.global_position
		var direction = move_to - transform.origin
		direction = lerp(direction, direction.normalized() * speed, 0.5)
		
		move_and_slide(direction)
	


func _on_Player_absorbing_blood():
	MOVE = true
	ABSORB = true


func _on_Player_stop_absorbing_blood():
	MOVE = false
	ABSORB = false


func _on_Player_detector_body_entered(body):
	if MOVE == true:
		if body.name == "Player":
			Autoload.BLOOD_LEVEL += 1
			queue_free()


func _on_Timer_timeout():
	queue_free()
