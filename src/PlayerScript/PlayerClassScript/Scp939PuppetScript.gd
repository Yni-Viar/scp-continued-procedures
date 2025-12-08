extends BasePuppetScript
## SCP-939 puppet script
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License
class_name Scp939PuppetScript

## Generic wander is MovableNpc wander implementation
## Special wander is limited wander, unique to SCP-939, contained in their chamber.
## If they leave containment chamber, wandering system will be switched to generic wander.
enum WanderingSystem {GENERIC_WANDER, SPECIAL_WANDER}

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var heat_targets: Array[Node3D] = []

## Attack timer
var attack_update_timer: float = 0.0
var wandering_timer: float = 0.0
var is_attacking: bool = false
var current_target: Node3D

var wandering_system: WanderingSystem = WanderingSystem.SPECIAL_WANDER

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match state:
		States.IDLE:
			set_state("939_Idle")
			special_wander()
		States.WALKING:
			set_state("939_Walking")
		States.RUNNING:
			set_state("939_Running")
	if is_attacking:
		attack()

func special_wander():
	if !get_parent().get_parent().optimizator_paused:
		if wandering_timer > 0:
			wandering_timer -= get_physics_process_delta_time()
		elif wandering_system == WanderingSystem.SPECIAL_WANDER && state == States.IDLE:
			if get_tree().get_node_count_in_group("Scp939Point") > 0:
				get_parent().get_parent().set_target_position(get_tree().get_nodes_in_group("Scp939Point")[rng.randi_range(0, get_tree().get_node_count_in_group("Scp939Point") - 1)].global_position)
				wandering_timer = 5.0
			else:
				wandering_system = WanderingSystem.GENERIC_WANDER

func set_state(anim: String):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)

func attack():
	if attack_update_timer > 0:
		attack_update_timer -= get_physics_process_delta_time()
	else:
		current_target = get_node(get_parent().get_parent().follow_target)
		if current_target != null:
			set_state("939_Attack" + str(rng.randi_range(1, 3)))
			current_target.health_manage(-100.0)
			heat_targets.erase(current_target)
			current_target = null
			if heat_targets.size() > 0:
				get_parent().get_parent().follow_target = heat_targets[0].get_path()
			else:
				get_parent().get_parent().follow_target = ""
				if wandering_system == WanderingSystem.GENERIC_WANDER:
					get_parent().get_parent().wandering = true
		attack_update_timer = 2.0

func _on_trigger_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.puppet_class_name != "SCP-939":
			if body.is_player:
				body.get_node("StatusEffects").apply_status_effect("Amnesia", 1.0, 0.0)
			heat_targets.append(body)
			get_parent().get_parent().follow_target = body.get_path()
			if wandering_system == WanderingSystem.GENERIC_WANDER:
				get_parent().get_parent().wandering = false

func _on_trigger_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.puppet_class_name != "SCP-939":
			if body.is_player:
				body.get_node("StatusEffects").apply_status_effect("Amnesia", 0.0, 0.0)
			heat_targets.erase(body)
			if heat_targets.is_empty():
				get_parent().get_parent().follow_target = ""
				if wandering_system == WanderingSystem.GENERIC_WANDER:
					get_parent().get_parent().wandering = true

func _on_attack_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.puppet_class_name != "SCP-939":
			is_attacking = true

func _on_attack_body_exited(body: Node3D) -> void:
	if body == get_node(get_parent().get_parent().follow_target):
		is_attacking = false

func _on_run_trigger_body_entered(body: Node3D) -> void:
	if body is MovableNpc && heat_targets.has(body) && body.puppet_class.puppet_class_name != "SCP-939":
		get_parent().get_parent().character_speed = 12.0


func _on_run_trigger_body_exited(body: Node3D) -> void:
	if body is MovableNpc && heat_targets.has(body) && body.puppet_class.puppet_class_name != "SCP-939":
		get_parent().get_parent().character_speed = 6.0
