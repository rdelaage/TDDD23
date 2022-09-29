extends KinematicBody2D

var speed: int = 200
var jump_speed: int = 200
var gravity: int = 200
var velocity = Vector2()
var double_jump_used: bool = false
var nextLevel = String()

onready var _animated_sprite = $AnimatedSprite

func get_input(delta):
	if double_jump_used:
		if is_on_floor() and rotation_degrees == 0:
			double_jump_used = false
		elif is_on_ceiling() and rotation_degrees != 0:
			double_jump_used = false
			
	velocity.x = 0
	
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		if rotation_degrees == 0:
			_animated_sprite.play("run_right")
		else:
			_animated_sprite.play("run_left")
	else:
		_animated_sprite.stop()
		
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		if rotation_degrees == 0:
			_animated_sprite.play("run_left")
		else:
			_animated_sprite.play("run_right")
	else:
		_animated_sprite.stop()
		
	if Input.is_action_just_pressed("jump"):
		if rotation_degrees == 0:
			if is_on_floor():
				velocity.y -= jump_speed
			elif !double_jump_used:
				velocity.y -= jump_speed/2
				double_jump_used = true
		else:
			if is_on_ceiling():
				velocity.y += jump_speed
			elif !double_jump_used:
				velocity.y += jump_speed/2
				double_jump_used = true
			
	if Input.is_action_just_pressed("invert_gravity"):
		gravity *= -1
		rotation_degrees = fmod((rotation_degrees + 180), 360)
		
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	pass

func _physics_process(delta):
	get_input(delta)

func reset():
	var global = get_node("/root/Global")
	get_tree().change_scene(global.currentLevel)

func camera_animation_y():
	print("move")
	$AnimationPlayer.play("top")

func onLevelFinished():
	var global = get_node("/root/Global")
	speed = 0
	jump_speed = 0
	nextLevel = global.nextLevel
	$ButtonMenu.visible = true
	if nextLevel != "":
		$ButtonNext.visible = true

func _on_ButtonMenu_pressed():
	get_tree().change_scene("res://levels/MainMenu.tscn")


func _on_ButtonNext_pressed():
	if nextLevel != "":
		get_tree().change_scene(nextLevel)
