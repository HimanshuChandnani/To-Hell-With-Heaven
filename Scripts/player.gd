extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var ballIsInHands = false
@onready var ball = $"../Chain/Ball"

var on = 0

func _physics_process(delta):
	if on:
		# Putting ball in hand
		if Input.is_action_just_pressed("interact") and ballIsInHands == true:
			ballIsInHands = false
			$"../Chain/PinJoint2D7".softness = 16
			$Label.visible = false
		elif Input.is_action_just_pressed("interact") and ballIsInHands == false and global_position.distance_to(ball.global_position) < 10 or ballIsInHands == true:
			ballIsInHands = true
			ball.global_position = Vector2(global_position.x,global_position.y-5)
			$"../Chain/PinJoint2D7".softness = 0
			# Ball throw and mouse movement
			var mousePosition = get_global_mouse_position()
			$Label.visible = true
			$Label.rotation = global_position.angle_to_point(mousePosition)
			var temp = global_position.angle_to_point(mousePosition)
			if Input.is_action_just_pressed("throw"):
				ballIsInHands = false
				$Label.visible = false
				$"../Chain/PinJoint2D7".softness = 16
				ball.apply_impulse(Vector2(cos(temp),sin(temp))*10000)
		if global_position.distance_to(ball.global_position) < 10:
			$"../Chain/Label".visible = true
			$"../Chain/Label".global_position = Vector2(ball.global_position.x,ball.global_position.y-7)
		else:
			$"../Chain/Label".visible = false
		# Slow down
		var slow = 1
		if global_position.distance_to(ball.global_position) > 25 or ballIsInHands:
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
		
		# Get pulled towards ball
		if global_position.distance_to(ball.global_position) > 37:
			velocity = global_position.direction_to(ball.global_position) * SPEED 
		# Pull yourself
		if Input.is_action_pressed("pull") and global_position.distance_to(ball.global_position) > 10:
			velocity = global_position.direction_to(ball.global_position) * SPEED * 2
		
		move_and_slide()
