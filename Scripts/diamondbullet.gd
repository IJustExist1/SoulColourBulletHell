extends StaticBody2D

var velocity = Vector2.DOWN
var speed = 5
var deletionpoint = Vector2.AXIS_Y

func _ready():
	deletionpoint = 800
 
func _process(_delta):
	translate(velocity * speed)
	if self.global_position.y >= deletionpoint:
		queue_free()
	
