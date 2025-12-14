extends Area3D
## Made by Yni, licensed under MIT License.

@export var elevator_path: NodePath
@export var elevator_path_global: String

func _on_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.is_player:
			if !elevator_path.is_empty():
				get_tree().root.get_node("Game/UI").current_elevator = get_node(elevator_path)
			else:
				get_tree().root.get_node("Game/UI").current_elevator = get_node(elevator_path_global)
			get_tree().root.get_node("Game/UI/HBoxContainer/ElevatorButton").show()


func _on_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.is_player:
			get_tree().root.get_node("Game/UI/HBoxContainer/ElevatorButton").hide()
