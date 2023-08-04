extends StaticBody2D

var velocity = Vector2.UP
@export var speed = 5
var deletionpoint = Vector2.AXIS_X

func _ready():
	deletionpoint = 1000
	self.global_position = get_node("/root/World/player").global_position 

func _process(delta):
	translate((velocity * speed) * delta * 100)
	if self.global_position.x >= deletionpoint:
		self.queue_free()
