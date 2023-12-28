extends RigidBody3D

## How much vertical force is applied
@export_range(500.0, 2000.0) var thrust: float = 1000.0
## How much left or right torque is applied
@export_range(50.0, 200.0) var torque_thrust: float = 100.0

var is_transitioning: bool = false

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
	if !is_transitioning:
		if body.is_in_group("Goal"):
		#if "Goal" in body.get_groups():
			complete_level(body.file_path)
		elif body.is_in_group("GameOver"):
			crash_sequence()

func crash_sequence() -> void:
	print("GameOver")
	#For stop to call de _process function and not move the player
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().reload_current_scene)

func complete_level(next_level_file: String) -> void:
	print("level completed")
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))
