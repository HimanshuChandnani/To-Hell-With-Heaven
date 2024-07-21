extends Node2D

@onready var rykting = $Rykting/Player
@onready var camera = $Camera

func _physics_process(delta):
	if camera.global_position.x < rykting.global_position.x:
		camera.global_position.x += 2
	if camera.global_position.x > rykting.global_position.x:
		camera.global_position.x -= 2
	if camera.global_position.y < rykting.global_position.y:
		camera.global_position.y += 2
	if camera.global_position.y > rykting.global_position.y:
		camera.global_position.y -= 2
