extends Area2D

const SPEED = 0.025
const DAMAGE = 5
var velocity = Vector2()

func _ready():
	pass

func _physics_process(delta):
	$AnimatedSprite.play("burning")
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Fireball_body_entered(body):
	if "enemy" in body.name:
		body.take_damage(DAMAGE)
	queue_free()
