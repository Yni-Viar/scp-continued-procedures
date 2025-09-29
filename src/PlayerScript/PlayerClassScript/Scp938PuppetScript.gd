extends BasePuppetScript
## SCP-938 puppet script
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License
class_name Scp938PuppetScript

enum Scp938State{DORMANT, ACTIVE_WANDERING, ACTIVE_ATTACKING}

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var current_state: Scp938State = Scp938State.DORMANT
var electro_targets: Array[Node3D] = []
var timer: float = 8.75
var teleport_timer: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AttackArea.monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	scp_938(delta)

func scp_938(delta: float):
	if timer > 0:
		if electro_targets.size() > 0 || current_state != 0:
			timer -= delta
	else:
		current_state = rng.randi_range(1, 2) as Scp938State
		$AttackArea.monitoring = true
		teleport_timer = 0.0
	match current_state:
		1:
			if teleport_timer > 0:
				teleport_timer -= delta
			else:
				if !get_parent().get_parent().wandering:
					get_parent().get_parent().wandering = true
				teleport_timer = rng.randf_range(3.0, 4.0)
				get_parent().get_parent().global_position = NavigationServer3D.map_get_random_point(get_parent().get_parent().get_node("NavigationAgent3D").get_navigation_map(), 1, true)
		2:
			if electro_targets.size() > 0:
				if teleport_timer > 0:
					teleport_timer -= delta
				else:
					if get_parent().get_parent().wandering:
						get_parent().get_parent().wandering = false
					teleport_timer = rng.randf_range(0.4375, 0.75)
					var target = electro_targets[randi_range(0, electro_targets.size()-1)]
					get_parent().get_parent().global_position = target.global_position - target.global_transform.basis.z * 2
			else:
				current_state = 1 as Scp938State

func _on_trigger_area_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.fraction != 1 && body.puppet_class.fraction != 2:
			electro_targets.append(body)

func _on_attack_area_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		$AttackTrigger.look_at(body)
		$AttackTrigger.show()
		body.movement_freeze = true
		await get_tree().create_timer(1.0).timeout
		body.health_manage(-80)
		$AttackTrigger.hide()
		body.movement_freeze = false


func _on_trigger_area_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.fraction != 1 && body.puppet_class.fraction != 2 && current_state == 0:
			electro_targets.erase(body)
