extends RigidBody2D

var Gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	#position.y = Gravity * 0.1 * delta
	#print(Gravity)
	pass
