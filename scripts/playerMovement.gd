extends CharacterBody2D

const MAX_SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1000.0
const FRICTION = 800.0
var coyote_timer = 0

@onready var player: CharacterBody2D = $"."
@onready var STARTING_POSITION: Vector2 = player.position

func _physics_process(delta: float) -> void:
	var on_ground = $FloorRayCast.is_colliding()
	# Add the gravity.
	if is_on_floor():
		velocity.y = 0
	else:
		if velocity.y > 0:
			velocity += get_gravity() * delta
		else:
			velocity += get_gravity() * 1.3 * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (on_ground or (coyote_timer > 0 and velocity.y >= 0)):
		velocity.y = JUMP_VELOCITY
	if on_ground:
		coyote_timer = 1
	else:
		coyote_timer -= 10 * delta 
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if(abs(velocity.x) < MAX_SPEED):
			velocity.x += direction * ACCELERATION * delta
		else:
			velocity.x = direction * MAX_SPEED
	else:
		if(velocity.x > 0):
			velocity.x -= FRICTION * delta
		elif(velocity.x < 0):
			velocity.x += FRICTION * delta
		if(abs(velocity.x) < 30):
			velocity.x = 0

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	player.position = STARTING_POSITION
