extends Node3D

var rng: RandomNumberGenerator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.current_season == Settings.Season.CHRISTMAS:
		#set random color
		rng = get_tree().root.get_node("Game").rng
		var mat: ShaderMaterial = $Cylinder_001.mesh.surface_get_material(1)
		mat.set_shader_parameter("emission", Color(rng.randf(), rng.randf(), rng.randf()))
		$Cylinder_001.mesh.surface_set_material(1, mat)
