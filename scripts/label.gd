extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".text ="test"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		$".".text = event.as_text()
