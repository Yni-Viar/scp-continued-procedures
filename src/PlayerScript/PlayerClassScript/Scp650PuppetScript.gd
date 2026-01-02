extends VisionScpPuppetScript
## SCP-650 puppet script
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License
class_name Scp650PuppetScript

@export var scp_650_variations_default: Dictionary[String, Dictionary] = {
		"res://Assets/ExternalModels/SCP/scp650/Scp650.gltf": {
			"CHRISTMAS": {
				"Scp650/Armature/Skeleton3D/650": [
					[0, "albedo_texture", "res://Assets/ExternalModels/SCP/scp650/christmas/650_Base_Color.png"]
				]
			}
		}
	}
@export var wait_seconds: float = 5
@export_group("PluginAPI")
@export var scp_650_variations: Dictionary[String, Dictionary]
var timer = 0

# Called when the node enters the scene tree for the first time.
func on_start() -> void:
	set_scp650_variations({})
	spawn_scp_variation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#If is not watching
	if watching_puppets.size() == 0:
		#Wait
		timer += delta
		if timer >= wait_seconds:
			var players = get_tree().get_nodes_in_group("Players")
			var random_human: Node3D = players[rng.randi_range(0, players.size() - 1)]
			#Action. We move SCP-650 to player's global position - offset (which is transform.basis.z) * how far SCP-650 will be from player
			get_parent().get_parent().global_position = random_human.global_position - random_human.global_transform.basis.z * 2
			set_state("Pose " + str(rng.randi_range(4, 10)))
			# Look at player
			look_at(random_human.global_position)
			# reset timer
			timer = 0
	else:
		# reset timer
		timer = 0

func apply_festive_skin():
	pass

## Animation state
func set_state(s):
	if get_child_count() > 0:
		if get_child(0).get_node_or_null("AnimationPlayer") != null:
			# if animation is the same, do nothing, else play new animation
			if get_child(0).get_node("AnimationPlayer").current_animation == s:
				return
			get_child(0).get_node("AnimationPlayer").play(s, 0.3)

func set_scp650_variations(path_array: Dictionary[String, Dictionary]):
	scp_650_variations.clear()
	# Add default variations gltf
	for path in scp_650_variations_default:
		if path.begins_with("res://") || path.begins_with("user://"):
			scp_650_variations[path] = scp_650_variations_default[path]
	# Add external variations
	for path in path_array:
		if path.begins_with("res://") || path.begins_with("user://"):
			scp_650_variations[path] = path_array[path]

func spawn_scp_variation():
	if get_child_count() > 0:
		for node in get_children():
			node.queue_free()
	var scp_650_current_id = rng.randi_range(0, scp_650_variations.size() - 1)
	var scp_650: Node3D = load_gltf(scp_650_variations.keys()[scp_650_current_id])
	add_child(scp_650, true)
	scp_650.rotation = rotation - Vector3(0.0, PI, 0.0)
	skins = scp_650_variations[scp_650_variations.keys()[scp_650_current_id]]
	apply_skin()
