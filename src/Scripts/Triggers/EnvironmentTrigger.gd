extends Area3D
## Switches environment
## Made by Yni, licensed under MIT License.

@export var env: Environment



func _on_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.is_player:
			get_tree().root.get_node("Game/WorldEnvironment").environment = env
			get_tree().root.get_node("Game/WorldEnvironment").environment.glow_enabled = Settings.setting_res.glow
			get_tree().root.get_node("Game/WorldEnvironment").environment.ssao_enabled = Settings.setting_res.ssao


func _on_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.is_player:
			get_tree().root.get_node("Game/WorldEnvironment").environment = load("res://Assets/Environment/Default.tres")
			get_tree().root.get_node("Game/WorldEnvironment").environment.glow_enabled = Settings.setting_res.glow
			get_tree().root.get_node("Game/WorldEnvironment").environment.ssao_enabled = Settings.setting_res.ssao
