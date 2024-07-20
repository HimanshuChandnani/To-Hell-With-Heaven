extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	var ballIsCloseX = 1
	if $"../Chain/Ball".position.x - $"../Chain/Chain segment".position.x > 12:
		ballIsCloseX = 5
	var ballIsCloseY = 1
	if $"../Chain/Ball".position.y - $"../Chain/Chain segment".position.y > 12:
		ballIsCloseY = 5
	#print(position.distance_to($"../Chain/Ball".position))
	print($"../Chain/Ball".position - $"../Chain/Chain segment".position)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY / ballIsCloseY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED / ballIsCloseX
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
