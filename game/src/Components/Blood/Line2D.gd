extends Line2D

export var length = 1000
var point = Vector2()

func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	
	point = get_parent().global_position
	
	if get_parent().MOVE == true:
		add_point(point)
	
	while get_point_count() > length and get_parent().MOVE == true:
		remove_point(0)
