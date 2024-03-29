extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FLOOR_FRICTION = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var base_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_normal_distance = 875

func _physics_process(delta):
	up_direction = -position.normalized()
	rotation = position.angle() - PI / 2

	var local_velocity = velocity.rotated(-rotation)

	if not is_on_floor():
		local_velocity.y += base_gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		local_velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		local_velocity.x = direction * SPEED
		$AnimatedSprite2D.play()
	else:
		local_velocity.x = move_toward(local_velocity.x, 0, FLOOR_FRICTION)
		$AnimatedSprite2D.stop()

	velocity = local_velocity.rotated(rotation)

	move_and_slide()
