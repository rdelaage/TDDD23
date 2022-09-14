extends KinematicBody2D

var speed: int = 200
var jump_speed: int = 200
var gravity: int = 200
var velocity = Vector2()

onready var _animated_sprite = $AnimatedSprite

func get_input(delta):
	if is_on_floor() or is_on_ceiling():
		velocity.x = 0
	
	if Input.is_action_pressed("move_right"):
		if rotation_degrees == 0:
			if is_on_floor():
				velocity.x += speed
				_animated_sprite.play("run_right")
		else:
			if is_on_ceiling():
				velocity.x += speed
				_animated_sprite.play("run_left")
	else:
		_animated_sprite.stop()
		
	if Input.is_action_pressed("move_left"):
		if rotation_degrees == 0:
			if is_on_floor():
				velocity.x -= speed
				_animated_sprite.play("run_left")
		else:
			if is_on_ceiling():
				velocity.x -= speed
				_animated_sprite.play("run_right")
	else:
		_animated_sprite.stop()
		
	if Input.is_action_pressed("jump"):
		if rotation_degrees == 0:
			if (is_on_floor()):
				velocity.y -= jump_speed
		else:
			if (is_on_ceiling()):
				velocity.y += jump_speed
			
	if Input.is_action_just_pressed("invert_gravity"):
		gravity *= -1
		rotation_degrees = fmod((rotation_degrees + 180), 360)
		
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	pass

func _physics_process(delta):
	get_input(delta)
