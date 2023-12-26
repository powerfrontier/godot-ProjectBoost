extends RigidBody3D

## How much vertical force is applied
@export_range(500.0, 2000.0) var thrust: float = 1000.0
## How much left or right torque is applied
@export_range(50.0, 200.0) var torque_thrust: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0, 0, torque_thrust * delta))
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0, 0, -torque_thrust * delta))


func _on_body_entered(body):
	if body.is_in_group("Goal"):
	#if "Goal" in body.get_groups():
		complete_level()
	elif body.is_in_group("GameOver"):
		crash_sequence()

func crash_sequence() -> void:
	print("GameOver")
	get_tree().reload_current_scene()

func complete_level() -> void:
	print("level completed")
	get_tree().quit()
