extends Node2D

@onready var rykting = $Rykting/Player
@onready var camera = $Camera
@onready var killzone = $Killzone
@onready var startarea = $Startarea

func _physics_process(_delta):
	if camera.global_position.x < rykting.global_position.x+10:
		camera.global_position.x += 10
	if camera.global_position.x > rykting.global_position.x-10:
		camera.global_position.x -= 10
	if camera.global_position.y < rykting.global_position.y+10:
		camera.global_position.y += 10
	if camera.global_position.y > rykting.global_position.y-10:
		camera.global_position.y -= 10

	if killzone.fly == true:
		$Rykting/Player/Halo.visible = true
		if startarea.start_pos != rykting.global_position:
			if rykting.global_position.x < startarea.start_pos.x+2:
				rykting.global_position.x += 10
			if rykting.global_position.x > startarea.start_pos.x-2:
				rykting.global_position.x -= 10
			if rykting.global_position.y < startarea.start_pos.y+2:
				rykting.global_position.y += 10
			if rykting.global_position.y > startarea.start_pos.y-2:
				rykting.global_position.y -= 10
		else:
			killzone.fly = false
			$Rykting/Player/Halo.visible = false
