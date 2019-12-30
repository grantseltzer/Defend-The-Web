extends Node2D

func start():
	$AnimatedSprite.play("default")

func stop():
	$AnimatedSprite.play("still")