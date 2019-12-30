extends KinematicBody2D

const SPEED = 15

var velocity = Vector2()
var health_points = 10

var timer = null
var delay = randi()%5+1
var is_dead = false

func _ready():

	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(delay)
	timer.connect("timeout", self, "on_timeout")
	timer.start()
	add_child(timer)

func take_damage(damage_points):
	health_points -= damage_points
	
	if health_points <= 0:
		is_dead = true
		$AnimatedSprite.play("dead")
		velocity = Vector2(0,0)
		
func _physics_process(delta):
	if is_dead:
		return
	
	move_and_slide(velocity)
		
	if is_on_wall():
		velocity.x *= -1
		velocity.y *= -1
		
func on_timeout():
	if is_dead:
		return
	timer.start()
	change_random_direction()
	
func change_random_direction():
	var newDirection = randi()%11+1

	if newDirection == 2: 
		$AnimatedSprite.play("walk")
		velocity.x = SPEED
		velocity.y = 0
	elif newDirection == 3:
		$AnimatedSprite.play("walk")
		velocity.x = -SPEED
		velocity.y = 0
	elif newDirection == 4:
		$AnimatedSprite.play("walk")
		velocity.x = 0
		velocity.y = SPEED
	elif newDirection == 5:
		$AnimatedSprite.play("walk")
		velocity.x = 0
		velocity.y = -SPEED
	else:
		$AnimatedSprite.play("idle")
		velocity.x = 0
		velocity.y = 0
	





