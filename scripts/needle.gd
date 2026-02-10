extends StaticBody2D

var isMoving: bool = false
var direction: Vector2
var speed: int = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isMoving:
		position += direction*speed*delta

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		direction = get_global_mouse_position()
		look_at(direction)
		reparent(get_tree().current_scene, true)
		isMoving = true
