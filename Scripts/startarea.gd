extends Area2D

var start_pos

func _on_body_entered(body):
	start_pos = body.global_position
