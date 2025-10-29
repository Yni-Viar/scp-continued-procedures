extends BasePuppetScript
## Example implementation of human system.
## Made by Yni, licensed under MIT license.
class_name HumanPuppetScript

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

enum SecondaryState {NONE, ITEM, CUFFED, JAILBIRD_ATTACK, INTERACT, MTF_RIFLE, CI_RIFLE}

@export var enable_secondary_state: bool = true
@export var secondary_state: SecondaryState = SecondaryState.NONE
@export var resistance_scp686: bool = false
@export var torso_node_path: NodePath

var cuffed_players: Array[MovableNpc] = []
var raycast: RayCast3D
var vision_entity: Array = []
var has_animtree: bool = false
var has_lookat_ik: bool = false
var looking_at_target: bool = false
var update_timer = 1.0

# Called when the node enters the scene tree for the first time.
func on_start():
	raycast = get_parent().get_parent().get_node("RayCast3D")
	if get_node_or_null("AnimationTree") != null:
		get_node("AnimationTree").active = true
		has_animtree = true
	if get_node_or_null(armature_name + "/Skeleton3D/LookAtModifier3D") != null && get_parent().get_parent().puppet_class.enable_ik:
		has_lookat_ik = true
	#get_parent().get_node("NpcSelection").set_collision_mask_value(3, true)
	if get_node(torso_node_path) == null:
		resistance_scp686 = true
	on_start_human()

func on_start_human():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Change animation state
	if has_animtree:
		match state:
			States.IDLE:
				if !get_node("AnimationTree").get("parameters/state_machine/blend_amount") - 0.00001 < -1:
					call("set_state", "state_machine", "blend_amount", lerp(get_node("AnimationTree").get("parameters/state_machine/blend_amount"), -1.0, get_parent().get_parent().character_speed * delta))
			States.WALKING:
				if !get_node("AnimationTree").get("parameters/state_machine/blend_amount") + 0.00001 > 0:
					call("set_state", "state_machine", "blend_amount", lerp(get_node("AnimationTree").get("parameters/state_machine/blend_amount"), 0.0, get_parent().get_parent().character_speed * delta))
			States.RUNNING:
				if !get_node("AnimationTree").get("parameters/state_machine/blend_amount") + 0.00001 > 1:
					call("set_state", "state_machine", "blend_amount", lerp(get_node("AnimationTree").get("parameters/state_machine/blend_amount"), 1.0, get_parent().get_parent().character_speed * delta))
		if enable_secondary_state:
			match secondary_state:
				SecondaryState.NONE:
					if !get_node("AnimationTree").get("parameters/items_blend/blend_amount") - 0.00001 < 0:
						call("set_state", "items_blend", "blend_amount", lerp(get_node("AnimationTree").get("parameters/items_blend/blend_amount"), 0.0, get_parent().get_parent().character_speed * delta))
				SecondaryState.ITEM:
					call("set_state", "secondary_state", "transition_request", "item")
				SecondaryState.CUFFED:
					call("set_state", "secondary_state", "transition_request", "cuffed")
				SecondaryState.JAILBIRD_ATTACK:
					call("set_state", "secondary_state", "transition_request", "jailbird_attack")
				SecondaryState.INTERACT:
					call("set_state", "secondary_state", "transition_request", "interact")
				SecondaryState.MTF_RIFLE:
					call("set_state", "secondary_state", "transition_request", "mtf_rifle")
				SecondaryState.CI_RIFLE:
					call("set_state", "secondary_state", "transition_request", "ci_rifle")
			if secondary_state != SecondaryState.NONE:
				if !get_node("AnimationTree").get("parameters/items_blend/blend_amount") + 0.00001 > 1:
					call("set_state", "items_blend", "blend_amount", lerp(get_node("AnimationTree").get("parameters/items_blend/blend_amount"), 1.0, get_parent().get_parent().character_speed * delta))
	
	## Look at enemy
	if active_puppets.size() > 0 && state == States.IDLE:
		var prev_entity_distance: float = 16777216
		var index = 0
		# Fixing scientist not looking at 650 - now people will look at the nearest object
		for i in range(active_puppets.size()):
			var entity_distance: float = active_puppets[i].global_position.distance_to(get_parent().global_position)
			if entity_distance < prev_entity_distance || i == active_puppets.size() - 1:
				prev_entity_distance = entity_distance
				index = i
		
		var looking_object: Node3D
		
		# If there is must-not-look SCP (like 023), just watch SafePoint. Else, look directly, as 173 or 650
		if active_puppets[index].puppet_class.fraction == 3 && \
		active_puppets[index].get_node_or_null("PlayerModel/Puppet/SafeZone") != null:
			looking_object = active_puppets[index].get_node("PlayerModel/Puppet/SafeZone")
		else:
			looking_object = active_puppets[index]
		
		if has_lookat_ik:
			get_parent().get_parent().get_node("RayCast3D").look_at(looking_object.global_position)
			get_node(armature_name + "/Skeleton3D/LookAtModifier3D").target_node = looking_object.get_path()
		elif active_puppets[index].puppet_class.fraction != 3:
			get_parent().get_parent().look_at(looking_object.global_position)
		looking_at_target = true
	elif looking_at_target:
		get_parent().get_parent().get_node("RayCast3D").rotation = Vector3.ZERO
		if has_lookat_ik:
			get_node(armature_name + "/Skeleton3D/LookAtModifier3D").target_node = ""
		looking_at_target = false
	
	# It handles watching at 173 and 650...
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is MovableNpc:
			var puppet_class = collider.puppet_class
			if puppet_class.fraction == 2: # Need-to-look SCPs
				vision_entity.append(collider.get_node("PlayerModel/Puppet"))
				if !collider.get_node("PlayerModel/Puppet").watching_puppets.has(get_parent().get_parent()):
					collider.get_node("PlayerModel/Puppet").watching_puppets.append(get_parent().get_parent())
			elif vision_entity.size() > 0: # Release must-to-look SCPs
				for entity in vision_entity:
					entity.watching_puppets.clear()
				vision_entity.clear()
			_on_raycast_update_npc(collider.get_path())
		elif vision_entity.size() > 0:
			for entity in vision_entity:
				entity.watching_puppets.clear()
			vision_entity.clear()
		#else:
			#_on_raycast_update(collider.get_path())
	## Cuffed players mechanic
	#if cuffed_players.size() > 0:
		#target_follow(delta)
	on_update_human(delta)

func on_update_human(delta: float):
	pass

func _on_raycast_update_npc(collider_path: String):
	pass

## Set animation to an entity via Animation Tree.
func set_state(animation_name: String, action_name: String, amount):
	get_node("AnimationTree").set("parameters/" + animation_name + "/" + action_name, amount)

#func set_anim_state(animation_name: String):
	#$AnimationPlayer.play(animation_name)

## Playing footsteps
func footstep(key: String):
	get_parent().get_parent().get_node("WalkSounds").stream = load(get_parent().get_parent().puppet_class.footstep_sounds[key][rng.randi_range(0, get_parent().get_parent().puppet_class.footstep_sounds[key].size() - 1)])
	get_parent().get_parent().get_node("WalkSounds").play()

func hold_item(idx: int):
	if get_node_or_null(armature_name + "/Skeleton3D/ItemAttachment/Marker3D") != null:
		if get_parent().get_parent().is_player:
			if get_node(armature_name + "/Skeleton3D/ItemAttachment/Marker3D").get_child_count() > 0:
				for node in get_node(armature_name + "/Skeleton3D/ItemAttachment/Marker3D").get_children():
					node.queue_free()
				secondary_state = SecondaryState.NONE
			else:
				secondary_state = SecondaryState.ITEM
				var item_prefab: Pickable = load(get_tree().root.get_node("Game").gamedata.items[idx].pickable_path).instantiate()
				item_prefab.freeze = true
				get_node(armature_name + "/Skeleton3D/ItemAttachment/Marker3D").add_child(item_prefab)
			

func effect_manager_start(effect: String, strength: float):
	match effect:
		"Scp686":
			get_node(torso_node_path).mesh.surface_set_material(0, get_node(torso_node_path).mesh.surface_get_material(0).duplicate())
	effect_manager_start_custom(effect, strength)

func effect_manager_start_custom(effect: String, strength: float):
	pass

func effect_manager_update(effect: String, strength: float):
	match effect:
		"Scp686":
			if !resistance_scp686:
				if get_node(torso_node_path).mesh.surface_get_material(0).get_shader_parameter("tint")[0] < 0.95:
					var value: float = get_physics_process_delta_time() * 2 * strength
					get_node(torso_node_path).mesh.surface_get_material(0).set_shader_parameter("tint", get_node(torso_node_path).mesh.surface_get_material(0).get_shader_parameter("tint") + Color(value, value, value))
				get_parent().get_parent().health_manage(-get_physics_process_delta_time() * strength, 2)
	effect_manager_update_custom(effect, strength)

func effect_manager_update_custom(effect: String, strength: float):
	pass

## Follow the players, if cuffed
#func target_follow(delta: float):
	#if update_timer > 0:
		#update_timer -= delta
	#else:
		#for player in cuffed_players:
			#player.set_movement_target(get_parent().get_parent().global_position, true, false)
		#update_timer = 1.0
