extends KinematicBody2D

var velocity := Vector2.ZERO
var direction := Vector2.ZERO

var BULLET_SPEED = 200

signal bullet_hit

func _ready():
	print("BULLET HERE")

func _physics_process(delta):
	velocity.x = direction.x * BULLET_SPEED
	
	velocity = move_and_slide(velocity)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		queue_free()
		
		if collision.collider.is_in_group("enemy"):
			self.connect('bullet_hit', collision.collider, "on_Bullet_hit")
			emit_signal("bullet_hit")
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
