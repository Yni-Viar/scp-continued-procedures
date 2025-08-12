extends Area3D

@export var elevator_path: NodePath

func _on_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.is_player:
			get_tree().root.get_node("Game/UI").current_elevator = get_node(elevator_path)
			get_tree().root.get_node("Game/UI/HBoxContainer/ElevatorButton").show()


func _on_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.is_player:
			get_tree().root.get_node("Game/UI/HBoxContainer/ElevatorButton").hide()
