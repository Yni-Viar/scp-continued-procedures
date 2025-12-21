extends BasePuppetScript
## SCP-938 puppet script
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License
class_name Scp938PuppetScript

enum Scp938State{DORMANT = 0, ACTIVE_WANDERING = 1, ACTIVE_ATTACKING = 2}

var current_state: Scp938State = Scp938State.DORMANT
var electro_targets: Array[Node3D] = []
var timer: float = 24.0
var teleport_is_ready: bool = false
# Favourite SCP-938 target
var favourite_target: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AttackArea.monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	scp_938(delta)

func scp_938(delta: float):
	if electro_targets.size() > 0:
		if timer > 0 || current_state != 0:
			timer -= delta
		else:
			if !Settings.setting_res.zen_mode:
				get_tree().root.get_node("Game").finish_game(false, "GAME_OVER_2")
			current_state = rng.randi_range(1, 2) as Scp938State
			$AttackArea.monitoring = true
			teleport_is_ready = true
			timer = 8.0
	match current_state:
		1:
			if !get_parent().get_parent().wandering:
				get_parent().get_parent().wandering_system = MovableNpc.WanderingSystem.GENERIC_WANDER
			if teleport_is_ready:
				get_parent().get_parent().global_position = NavigationServer3D.map_get_random_point(get_parent().get_parent().get_node("NavigationAgent3D").get_navigation_map(), 1, true)
				teleport_is_ready = false
		2:
			if teleport_is_ready && electro_targets.size() > 0:
				teleport_is_ready = false
				get_parent().get_parent().wandering_system = MovableNpc.WanderingSystem.NONE
				# Firstly, choose random target
				var selection: int = randi_range(0, electro_targets.size()-1)
				# Secondly, choose should electrocute this target (0) or favourite (1)
				var choice_for_target: bool = randi_range(0, 1) as bool
				var target = electro_targets[selection if !choice_for_target else favourite_target]
				if target != null:
					get_parent().get_parent().global_position = target.global_position - target.global_transform.basis.z * 2
					if favourite_target < 0:
						favourite_target = selection
				elif electro_targets.size()-1 < favourite_target:
					favourite_target = randi_range(0, electro_targets.size()-1)
			else:
				current_state = 1 as Scp938State

func _on_trigger_area_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.fraction != 1 && body.puppet_class.fraction != 2 && !electro_targets.has(body):
			electro_targets.append(body)

func _on_attack_area_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.puppet_class_name != "SCP-938":
			body.movement_freeze = true
			$AttackTrigger.look_at(body.global_position)
			$AttackTrigger.show()
			await get_tree().create_timer(1.0).timeout
			body.health_manage(-80)
			$AttackTrigger.hide()
			if body != null:
				body.movement_freeze = false
			teleport_is_ready = true


func _on_trigger_area_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.fraction != 1 && body.puppet_class.fraction != 2 && current_state == 0 && electro_targets.has(body):
			electro_targets.erase(body)
			
