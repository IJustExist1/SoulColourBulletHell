extends CharacterBody2D

#Refrences
@onready var playeranim = $AnimationPlayer
@onready var heartsfx = $heartshot
@onready var shieldanim = $shield/AnimationPlayer
@onready var shield = $shield
@onready var bell = $bell

@export_category("Player Settings")
@export var SPEED = 200
@export var JUMP_HEIGHT = -500.0
@export var gravity = 980
@export var HEALTH = 120

@export_category("Debug")
@export var is_yellow_trans_finsished = false
@export var first_move = false

@export_category("Soul Colours")
@export var orange = false
@export var yellow = false
@export var green = false
@export var blue = false
@export var cyan = false
@export var purple = false

@export_category("Shield Rot")
@export var UP = false
@export var DOWN = false
@export var LEFT = false
@export var RIGHT = true

@export_category("Cyan Blocking")
@export var is_blocking = false


#Gets the Center of the arena
var heartcenter = Vector2.ZERO

func _ready():
	playeranim.queue("soul_appear")
	if first_move:
		playeranim.queue("soul_move_menu")
	else:
		playeranim.queue("soul_move_battle")

func _physics_process(delta):
	
	heartcenter.x = 310
	heartcenter.y = 250
	
	colour_handler()
	movement_handler(delta)
	

func colour_handler():
	if Input.is_action_just_pressed("toggle_blue") && yellow && !playeranim.is_playing():
		playeranim.play("blue_from_yellow")
		yellow = false
		green = false
		orange = false
		cyan = false
		purple = false
		
	if Input.is_action_just_pressed("toggle_green") && yellow && !playeranim.is_playing():
		playeranim.play("green_from_yellow")
		yellow = false
		blue = false
		orange = false
		cyan = false
		purple = false
	
	if Input.is_action_just_pressed("toggle_orange") && yellow && !playeranim.is_playing():
		playeranim.play("orange_from_yellow")
		yellow = false
		blue = false
		cyan = false
		green = false
		purple = false
		
	if Input.is_action_just_pressed("toggle_purple") && yellow && !playeranim.is_playing():
		playeranim.play("purple_from_yellow")
		yellow = false
		orange = false
		green = false
		blue = false
		cyan = false
	
	#Toggles Yellow
	if Input.is_action_just_pressed("toggle_yellow") && !yellow && !playeranim.is_playing():
		playeranim.play("change_to_yellow")
		yellow = true
		green = false
		blue = false
		purple = false
		cyan = false
		orange = false
	elif Input.is_action_just_pressed("toggle_yellow") && yellow && !playeranim.is_playing():
		playeranim.play("red_from_yellow")
		yellow = false
		green = false
		blue = false
		purple = false
		cyan = false
		orange = false
		
	#Toggles Green
	if Input.is_action_just_pressed("toggle_green") && !green && !playeranim.is_playing():
		playeranim.play("change_to_green")
		green = true
		blue = false
		yellow = false
		purple = false
		cyan = false
		orange = false
	elif Input.is_action_just_pressed("toggle_green") && green && !playeranim.is_playing():
		playeranim.play("change_to_red")
		green = false
		blue = false
		yellow = false
		purple = false
		cyan = false
		orange = false
		
	#Toggles Blue
	if Input.is_action_just_pressed("toggle_blue") && !blue && !playeranim.is_playing():
		playeranim.play("change_to_blue")
		blue = true
		green = false
		yellow = false
		purple = false
		cyan = false
		orange = false
	elif Input.is_action_just_pressed("toggle_blue") && blue && !playeranim.is_playing():
		playeranim.play("change_to_red")
		blue = false
		green = false
		yellow = false
		purple = false
		cyan = false
		orange = false
		
	if Input.is_action_just_pressed("toggle_purple") && !purple && !playeranim.is_playing():
		playeranim.play("change_to_purple")
		purple = true
		blue = false
		green = false
		yellow = false
		cyan = false
		orange = false
	elif Input.is_action_just_pressed("toggle_purple") && purple && !playeranim.is_playing():
		playeranim.play("change_to_red")
		purple = false
		blue = false
		green = false
		yellow = false
		cyan = false
		orange = false
		
	if Input.is_action_just_pressed("toggle_orange") && !orange && !playeranim.is_playing():
		playeranim.play("change_to_orange")
		orange = true
		purple = false
		blue = false
		green = false
		yellow = false
		cyan = false
	elif Input.is_action_just_pressed("toggle_orange") && orange && !playeranim.is_playing():
		playeranim.play("change_to_red")
		orange = false
		purple = false
		blue = false
		green = false
		yellow = false
		cyan = false
		
	if Input.is_action_just_pressed("toggle_cyan") && !cyan && !playeranim.is_playing() && !yellow:
		playeranim.play("change_to_cyan")
		orange = false
		purple = false
		blue = false
		green = false
		yellow = false
	elif Input.is_action_just_pressed("toggle_cyan") && cyan && !playeranim.is_playing():
		playeranim.play("change_to_red")
		orange = false
		purple = false
		blue = false
		green = false
		yellow = false
		cyan = false
	elif Input.is_action_just_pressed("toggle_cyan") && yellow && !playeranim.is_playing():
		playeranim.play("cyan_from_yellow")
		orange = false
		purple = false
		blue = false
		green = false
		yellow = false
func movement_handler(delta):
	if purple:
		position.y = heartcenter.y
	if green:
		position.x = heartcenter.x
		position.y = heartcenter.y
		if Input.is_action_just_pressed("up") && !shieldanim.is_playing():
			shieldanim.queue("up")
		elif Input.is_action_just_pressed("left") && !shieldanim.is_playing() && !DOWN:
			shieldanim.queue("left")
		elif Input.is_action_just_pressed("left") && !shieldanim.is_playing() && DOWN:
			shieldanim.play("left_from_down")
		elif Input.is_action_just_pressed("right") && !shieldanim.is_playing():
			shieldanim.queue("right")
		elif Input.is_action_just_pressed("down") && !shieldanim.is_playing():
			shieldanim.queue("down")

	if blue:
		if not is_on_floor():
			velocity.y += gravity * delta
		
		if is_on_floor():
			if Input.is_action_just_pressed("up"):
				velocity.y = JUMP_HEIGHT
		else:
			if Input.is_action_just_released("up") and velocity.y < JUMP_HEIGHT / 2:
				velocity.y = JUMP_HEIGHT / 2
			
	if yellow && Input.is_action_just_pressed("select") && is_yellow_trans_finsished:
		heartsfx.play()
		var heartshot = preload("res://Objects/heartshot.tscn")
		heartshot = heartshot.instantiate()
		add_sibling(heartshot)
		
	if !green && !orange && !cyan:
		var directionX = Input.get_axis("left", "right")
		if directionX:
			velocity.x = directionX * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	if !blue && !green && !purple && !orange && !cyan:
		var directionY = Input.get_axis("up","down")
		if directionY:
			velocity.y = directionY * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

	if orange:
		var directionX = Input.get_axis("left", "right")
		if directionX:
			velocity.x = directionX * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		var directionY = Input.get_axis("up","down")
		if directionY:
			velocity.y = directionY * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if cyan:
		if Input.is_action_just_released("select") && is_blocking == false:
			print("Blocking")
			bell.play()
			is_blocking = true
		elif Input.is_action_just_released("select") && is_blocking == true:
			print("Moving")
			bell.play()
			is_blocking = false
		
		if is_blocking == true:
			if Input.is_action_just_pressed("up") && !shieldanim.is_playing():
				shieldanim.queue("up")
			elif Input.is_action_just_pressed("left") && !shieldanim.is_playing() && !DOWN:
				shieldanim.queue("left")
			elif Input.is_action_just_pressed("left") && !shieldanim.is_playing() && DOWN:
				shieldanim.play("left_from_down")
			elif Input.is_action_just_pressed("right") && !shieldanim.is_playing():
				shieldanim.queue("right")
			elif Input.is_action_just_pressed("down") && !shieldanim.is_playing():
				shieldanim.queue("down")
			velocity = Vector2(0.0,0.0)
			shield.visible = true
		elif is_blocking == false:
			var directionX = Input.get_axis("left", "right")
			if directionX:
				velocity.x = directionX * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			
			var directionY = Input.get_axis("up","down")
			if directionY:
				velocity.y = directionY * SPEED
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
			shield.visible = false
	move_and_slide()
