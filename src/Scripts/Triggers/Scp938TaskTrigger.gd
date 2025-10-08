extends Area3D

var timer: float = 0.0
var player_came: bool = false
var class_d_amount: int = 0
var foundation_amount: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().root.get_node("Game/FoundationTask").has_task("task_938") && get_tree().get_node_count_in_group("DClassSpawn") == 0:
		get_tree().root.get_node("Game/FoundationTask").initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta: float) -> void:
	#if player_came:
		#timer += delta * 0.5
		#if timer > 1.0:
			#get_tree().root.get_node("Game/FoundationTask").do_task("task_938")
			#set_process(false)
			#set_physics_process(false)
			#monitoring = false
			#monitorable = false
	#else:
		#set_process(false)
		#set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.fraction == 0:
			match body.puppet_class.team:
				1:
					foundation_amount += 1
				2:
					class_d_amount += 1
		if class_d_amount >= 3 && foundation_amount >= 1:
			get_tree().root.get_node("Game/FoundationTask").do_task("task_938")


func _on_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.fraction == 0:
			match body.puppet_class.team:
				1:
					foundation_amount -= 1
				2:
					class_d_amount -= 1
