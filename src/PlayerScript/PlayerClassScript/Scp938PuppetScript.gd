extends BasePuppetScript
## SCP-938 puppet script
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License
class_name Scp938PuppetScript

enum Scp938State{DORMANT, ACTIVE_WANDERING, ACTIVE_ATTACKING}

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var current_state: Scp938State = Scp938State.DORMANT
var electro_targets: Array[Node3D] = []
var timer: float = 4.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	scp_938(delta)

func scp_938(delta: float):
	if electro_targets.size() > 0:
		if timer > 0:
			timer -= delta
		else:
			current_state = rng.randi_range(1, 2)
	else:
		timer = 5.0

func _on_trigger_area_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.fraction != 1 && body.puppet_class.fraction != 2:
			electro_targets.append(body)


func _on_attack_area_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		pass
