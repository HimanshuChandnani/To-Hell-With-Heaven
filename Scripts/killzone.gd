extends Area2D

var fly = false

func _on_body_entered(body):
	if body.has_method("player"):
		fly = true
