extends Node3D
## Made by Yni, licensed under CC0.

enum ObjectType {static_prefab, animated, ragdoll}
@export var state: String
@export var type: ObjectType = ObjectType.static_prefab
@export var armature_name: String = "Armature"
@export var seconds_before_despawn: float = 30.0

# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		ObjectType.animated:
			set_state(state)
		ObjectType.ragdoll:
			get_node(armature_name + "/Skeleton3D/PhysicalBoneSimulator3D").physical_bones_start_simulation()
	if seconds_before_despawn > 0.05:
		await get_tree().create_timer(seconds_before_despawn).timeout
		despawn()
	elif type == ObjectType.ragdoll:
		var timer: Timer = Timer.new()
		add_child(timer)
		timer.timeout.connect(check_distance)
		timer.wait_time = 2.0
		timer.start()

func set_state(s):
	if get_node("AnimationPlayer").current_animation != s:
		get_node("AnimationPlayer").play(s)

func despawn():
	if type == ObjectType.ragdoll:
		get_node(armature_name + "/Skeleton3D/PhysicalBoneSimulator3D").physical_bones_stop_simulation()
	queue_free()

func check_distance():
	if global_position.distance_to(get_tree().root.get_node("Game/StaticPlayer/Head/Camera3D").global_position) > 64.0:
		get_node(armature_name + "/Skeleton3D/PhysicalBoneSimulator3D").physical_bones_stop_simulation()
	else:
		get_node(armature_name + "/Skeleton3D/PhysicalBoneSimulator3D").physical_bones_start_simulation()
