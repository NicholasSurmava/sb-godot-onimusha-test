extends Line2D

var point
var point_speed_x = 1
var point_speed_y = 1
var BEING_ABSORED = false

func _ready():
	$Timer.start()
	point = Vector2(0,0)
	if Autoload.Player:
		Autoload.Player.connect('absorbing_blood', self, 'on_Being_absorbed')
	

# TODO: Need to randomize the drawing of the lines as they are instancing. So that they extend out in random directions.
# TODO: Need to also randomize the number of lines that are generated.
func _process(delta):
	point += Vector2(point_speed_x * delta, point_speed_y * delta)

func _on_Timer_timeout():
	add_point(point)
	
func on_Being_absorbed():
	print("ABSORBED!!!!")
	point_speed_x = Autoload.Player.global_position.x - self.global_position.x
	point_speed_y = Autoload.Player.global_position.y - self.global_position.y
