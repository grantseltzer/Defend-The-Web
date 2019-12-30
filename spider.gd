extends KinematicBody2D

var velocity = Vector2()
const BASE_SPEED = 60

const FIREBALL = preload("res://Fireball.tscn")

var is_attacking = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(get_global_mouse_position())

	var still = true

	# Shoot Fireball
	if Input.is_action_just_pressed("attack") && !is_attacking:
		is_attacking = true
		$AnimatedSprite.play("attack")
		shoot_fireball()

	if is_attacking:
		return

	# Take action from direction keys
	if Input.is_action_pressed("ui_right"):
		velocity.x = BASE_SPEED
		$AnimatedSprite.play("walking")
		still = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -BASE_SPEED
		$AnimatedSprite.play("walking")
		still = false
	else:
		velocity.x = 0
		still = true

	if Input.is_action_pressed("ui_up"):
		velocity.y = -BASE_SPEED
		$AnimatedSprite.play("walking")

		still = false
	elif Input.is_action_pressed("ui_down"):
		velocity.y = BASE_SPEED
		$AnimatedSprite.play("walking")

		still = false
	else:
		velocity.y = 0
		if still == true:
			$AnimatedSprite.play("standing")

		
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

func _on_AnimatedSprite_animation_finished():
	is_attacking = false
