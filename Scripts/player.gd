extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var ballIsInHands = false
@onready var ball = $"../Chain/Ball"

func _physics_process(delta):
	# Putting ball in hand
	if Input.is_action_just_pressed("interact") and ballIsInHands == true:
		ballIsInHands = false
	elif Input.is_action_just_pressed("interact") and ballIsInHands == false or ballIsInHands == true:
		ballIsInHands = true
		ball.global_position = position
	
	# Slow down
	var slow = 1
	print(position.distance_to(ball.global_position))
	if position.distance_to(ball.global_position) > 27:
		slow = 2
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY 

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
