extends Area3D
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License

var timer: float = 0.0
var player_came: bool = false
var class_d_amount: int = 0
var foundation_amount: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player_came:
		timer += delta * 0.5
		if timer > 1.0:
			get_tree().root.get_node("Game/FoundationTask").do_task("task_939")
			set_process(false)
			set_physics_process(false)
			monitoring = false
			monitorable = false


func _on_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.fraction == 0:
			match body.puppet_class.team:
				1:
					foundation_amount += 1
				2:
					class_d_amount += 1
		if class_d_amount >= 1 && foundation_amount >= 1:
			player_came = true


func _on_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.fraction == 0:
			match body.puppet_class.team:
				1:
					foundation_amount -= 1
				2:
					class_d_amount -= 1
		elif body.puppet_class.puppet_class_name == "SCP-939":
			var scp939 = body.get_node("PlayerModel/Puppet")
			if scp939 is Scp939PuppetScript:
				body.wandering_system = MovableNpc.WanderingSystem.GENERIC_WANDER
		#if class_d_amount < 1 && foundation_amount < 1:
			#player_came = false
