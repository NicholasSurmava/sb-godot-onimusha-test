extends Node2D

const CENTER = Vector2(50, 50)

const COLOR = Color(1, 1, 1, 1)

func _process(delta):
	update()
	


func _draw():
	draw_circle(CENTER, 10, COLOR)
	
	draw_line(CENTER, get_global_mouse_position(), COLOR)
