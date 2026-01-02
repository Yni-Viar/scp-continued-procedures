extends Node3D
## Made by Yni, licensed under CC0.
class_name BasePuppetScript



@export var armature_name: String = "HumanRig"
enum States {IDLE, WALKING, RUNNING, SPECIAL1, SPECIAL2, SPECIAL3, SPECIAL4}
@export var state: States = States.IDLE
@export var enable_vision_scan: bool = false
@export var vision_class_detect: Array[int] = [0]

@export_group("Festive settings")
## @deprecated
@export var fixed_prefab: bool = false
## @deprecated
## Format: NodePath: [[material_index, material], ...]
@export var christmas_suits: Dictionary[NodePath, Array]
## @deprecated
## Format: NodePath: [[material_index, material], ...]
@export var halloween_suits: Dictionary[NodePath, Array]
## Structure of v6 festive suit:
##"CHRISTMAS" / "HALLOWEEN" : {
##	"relative_node_path_string": [
##		[0, "ALBEDO", "path_to_your_retexture, begins with res:// or user://"]
##	]
##}
@export var skins: Dictionary

@export_group("PluginAPI")
@export var exposed_methods: Array[String]
var active_puppets: Array[Node3D] = []

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var cached_scenes: Dictionary[String, Node3D]

func _ready() -> void:
	if enable_vision_scan:
		get_parent().get_parent().get_node("VisionArea").connect("body_entered", on_vision_area_body_entered)
		get_parent().get_parent().get_node("VisionArea").connect("body_exited", on_vision_area_body_exited)
	
	if fixed_prefab:
		apply_festive_skin_legacy()
	
	on_start()

func on_start():
	pass

func on_vision_area_body_entered(body: Node3D):
	if body is MovableNpc:
		for puppet_class in vision_class_detect:
			if body.fraction == puppet_class:
				active_puppets.append(body)

func on_vision_area_body_exited(body: Node3D):
	if body is MovableNpc:
		if active_puppets.has(body):
			active_puppets.erase(body)

func special_action():
	pass

func effect_manager_start(effect: String, strength: float):
	pass

func effect_manager_update(effect: String, strength: float):
	pass

func effect_manager_destroy(effect: String, strength: float):
	pass

func apply_festive_skin_legacy():
	match Settings.current_season:
		Settings.Season.CHRISTMAS:
			for node_path in christmas_suits:
				for i in range(christmas_suits[node_path].size()):
					get_node(node_path).set_surface_override_material(christmas_suits[node_path][i][0], christmas_suits[node_path][i][1])
		Settings.Season.HALLOWEEN:
			for node_path in halloween_suits:
				for i in range(halloween_suits[node_path].size()):
					get_node(node_path).set_surface_override_material(halloween_suits[node_path][i][0], halloween_suits[node_path][i][1])


func apply_skin():
	match Settings.current_season:
		Settings.Season.CHRISTMAS:
			if skins.get("CHRISTMAS") != null:
				if skins["CHRISTMAS"] is not Dictionary:
					printerr("You specified wrong format. Debug code - ?. Cancelling festivizing...")
					return
				for node_path in skins["CHRISTMAS"]:
					if skins["CHRISTMAS"][node_path] is not Array:
						printerr("You specified wrong format. Debug code - { ? }. Cancelling festivizing...")
						continue
					for i in range(skins["CHRISTMAS"][node_path].size()):
						if skins["CHRISTMAS"][node_path][i] is not Array:
							printerr("You specified wrong format. Debug code - { [ ? ] }. Cancelling festivizing...")
							continue
						var material: Material = get_node(node_path).get_active_material(skins["CHRISTMAS"][node_path][i][0])
						if !skins["CHRISTMAS"][node_path][i][2].begins_with("res://") && !skins["CHRISTMAS"][node_path][i][2].begins_with("user://"):
							printerr("Wrong material. Cancelling festivizing...")
							continue
						if material is StandardMaterial3D:
							material.set(skins["CHRISTMAS"][node_path][i][1], load(skins["CHRISTMAS"][node_path][i][2]))
						elif material is ShaderMaterial:
							material.set_shader_parameter(skins["CHRISTMAS"][node_path][i][1], load(skins["CHRISTMAS"][node_path][i][2]))
						get_node(node_path).set_surface_override_material(skins["CHRISTMAS"][node_path][i][0], material)
		Settings.Season.HALLOWEEN:
			if skins.get("HALLOWEEN") != null:
				if skins["HALLOWEEN"] is not Dictionary:
					printerr("You specified wrong format. Debug code - ?. Cancelling festivizing...")
					return
				for node_path in skins["HALLOWEEN"]:
					if skins["HALLOWEEN"][node_path] is not Array:
						printerr("You specified wrong format. Debug code - { ? }. Cancelling festivizing...")
						continue
					for i in range(skins["HALLOWEEN"][node_path].size()):
						if skins["HALLOWEEN"][node_path][i] is not Array:
							printerr("You specified wrong format. Debug code - { [ ? ] }. Cancelling festivizing...")
							continue
						var material: Material = get_node(node_path).mesh.get_active_material(skins["HALLOWEEN"][node_path][i][0])
						if !skins["HALLOWEEN"][node_path][i][2].begins_with("res://") && !skins["HALLOWEEN"][node_path][i][2].begins_with("user://"):
							printerr("Wrong material. Cancelling festivizing...")
							continue
						if material is StandardMaterial3D:
							material.set(skins["HALLOWEEN"][node_path][i][1], load(skins["HALLOWEEN"][node_path][i][2]))
						elif material is ShaderMaterial:
							material.set_shader_parameter(skins["HALLOWEEN"][node_path][i][1], load(skins["HALLOWEEN"][node_path][i][2]))
						get_node(node_path).mesh.set_surface_override_material(skins["HALLOWEEN"][node_path][i][0], material)
		_:
			print("Generic skins not implemented yet.")

func pluginapi_call_method(method: String, args: Array):
	if exposed_methods.has(method):
		if args != null:
			if args.is_empty():
				call(method)
			else:
				call(method, args)
		else:
			printerr("args must not be null!")
	else:
		printerr("This method was not exposed, or it does not exist. Call canceled.")

## Loads GLTF models (currently used only for SCP-650) for PluginAPI
func load_gltf(path: String) -> Node3D:
	if cached_scenes.has(path):
		return cached_scenes[path].duplicate()
	var gltf_document_load = GLTFDocument.new()
	var gltf_state_load = GLTFState.new()
	var error = gltf_document_load.append_from_file(path, gltf_state_load)
	if error == OK:
		var gltf_scene_root_node = gltf_document_load.generate_scene(gltf_state_load)
		cached_scenes[path] = gltf_scene_root_node.duplicate()
		return gltf_scene_root_node
	else:
		return null

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		for key in cached_scenes:
			cached_scenes[key].queue_free()
