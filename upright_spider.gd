extends KinematicBody2D

var velocity = Vector2()
const BASE_SPEED = 100

const FIREBALL = preload("res://Fireball.tscn")

var is_attacking = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(get_global_mouse_position())

	var still = true
	
	var mouse_pos = get_global_mouse_position()
	var global_position = self.get_global_position()
	
	if mouse_pos.x < global_position.x:
		$AnimatedSprite.flip_v = true
		$Shadow.flip_v = true
	
	if mouse_pos.x >= global_position.x:
		$AnimatedSprite.flip_v = false
		$Shadow.flip_v = false
			
	# Shoot Fireball
	if Input.is_action_just_pressed("attack") && !is_attacking:
		is_attacking = true
		$AnimatedSprite.play("attacking")
		shoot_fireball()

	if is_attacking:
		return

	# Take action from direction keys
	if Input.is_action_pressed("ui_right"):
		velocity.x = BASE_SPEED
		$AnimatedSprite.play("walking")
		dust_move()
		still = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -BASE_SPEED
		$AnimatedSprite.play("walking")
		dust_move()
		still = false
	else:
		velocity.x = 0
		still = true

	if Input.is_action_pressed("ui_up"):
		velocity.y = -BASE_SPEED
		$AnimatedSprite.play("walking")
		dust_move()
		still = false
	elif Input.is_action_pressed("ui_down"):
		velocity.y = BASE_SPEED
		$AnimatedSprite.play("walking")
		dust_move()
		still = false
	else:
		velocity.y = 0
		if still == true:
			$AnimatedSprite.play("standing")
			dust_stop()

		
	move_and_slide(velocity)
	
func shoot_fireball():
	var mouse_pos = get_global_mouse_position()
	var global_position = self.get_global_position()
	
	var fireball = FIREBALL.instance()
	var fireball_rotation = get_angle_to(mouse_pos) + self.rotation
	fireball.rotate(fireball_rotation)
	fireball.set_global_position($Position2D.global_position)
	get_parent().add_child(fireball)
	fireball.velocity = (mouse_pos - global_position) * fireball.SPEED
	
func dust_move():
	$walkupdust1.start()
	$walkupdust2.start()
	
func dust_stop():
	$walkupdust1.stop()
	$walkupdust2.stop()
	
func _on_AnimatedSprite_animation_finished():
	is_attacking = false
