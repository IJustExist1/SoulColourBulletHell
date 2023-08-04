extends Node2D
@onready var intro = $intro
@onready var animation_player = $AnimationPlayer

@export_category("Debug")
@export var music_enabled = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if music_enabled:
		animation_player.play("intro")
