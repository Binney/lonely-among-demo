extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = 4000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var base_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_normal_distance = 875

func _physics_process(delta):
	up_direction = -position.normalized()
	rotation = position.angle() - PI / 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if not $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play()
		var x_velocity = direction * SPEED
		velocity = position.normalized().rotated(-PI / 2) * x_velocity
	else:
		var x_velocity = 0
		velocity = position.normalized().rotated(-PI / 2) * x_velocity
		if $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.stop()

	if not is_on_floor():
		var gravity = base_gravity * position / gravity_normal_distance
		velocity += gravity * delta

	move_and_slide()
