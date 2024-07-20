extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var player = $"../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = player.position
	print(position)
	print(player.position)
	pass
