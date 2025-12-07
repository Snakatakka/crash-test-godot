extends CharacterBody3D
@onready var sprite: AnimatedSprite3D = $Sprite

var flip_speed : float = 15.0
var face_right : bool = true
var face_up : bool = true
var gravity : float = 8.0

func _ready() -> void:
	sprite.play("idle")


@warning_ignore("unused_parameter")
func _physics_process(delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = Vector3.ZERO
	@warning_ignore("unused_variable")
	var new_animation : String = "idle"
	@warning_ignore("unused_variable")
	var new_suffix : String = ""
	
	velocity.y -= gravity
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -=1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -=1
	
	if input_dir.x > 0.0:
		face_right = true
	elif input_dir.x < 0.0:
		face_right = false
	
	if abs(input_dir.x) > (input_dir.y):
		face_up = false
	else:
		if input_dir.y < 0.0:
			face_up = true
		elif input_dir.y > 0.0:
			face_up = false
	
	if is_on_floor():
		if input_dir != Vector2.ZERO:
			new_animation = "walk"
		else:
			new_animation = "idle"
	
	if face_up:
		new_suffix = "_up"
	
	if face_right:
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, 0.0, flip_speed)
	else:
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, 180.0, flip_speed)
	
	sprite.play(new_animation + new_suffix)
	
	move_and_slide()
