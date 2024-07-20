extends Node2D

@onready var subtitle = $Subtitle

func _on_timer_timeout():
	if subtitle.visible == true:
		subtitle.visible = false
	else:
		subtitle.visible = true

func _physics_process(delta):
	if Input.is_action_just_pressed("Enter"):
		pass
