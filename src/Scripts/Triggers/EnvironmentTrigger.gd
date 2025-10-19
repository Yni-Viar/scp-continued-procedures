extends Area3D

@export var env: Environment



func _on_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.is_player:
			get_tree().root.get_node("Game/WorldEnvironment").environment = env


func _on_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.is_player:
			get_tree().root.get_node("Game/WorldEnvironment").environment = load("res://Assets/Environment/Default.tres")
