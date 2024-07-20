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
		$"../Chain/PinJoint2D7".softness = 16
	elif Input.is_action_just_pressed("interact") and ballIsInHands == false or ballIsInHands == true:
		ballIsInHands = true
		ball.global_position = Vector2(position.x,position.y-5)
		$"../Chain/PinJoint2D7".softness = 0
		# Mouse movement
		var mousePosition = get_global_mouse_position()
		#print(mousePosition)
		#print(position.angle_to_point(mousePosition))
		$Label.rotation = position.angle_to_point(mousePosition)
		if Input.is_action_just_pressed("left click"):
			ballIsInHands = false
			$"../Chain/PinJoint2D7".softness = 16
			ball.apply_central_impulse(mousePosition.normalized()*10000)
	
	# Slow down
	var slow = 1
	if position.distance_to(ball.global_position) > 25:
		slow = 2
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * slow

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY 

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED / slow
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	if direction == 0:
		$Sprite2D.play('idle')
	else:
		$Sprite2D.play('walk')
		
	move_and_slide()
