extends Node3D

enum Scp522State {DORMANT, ACTIVE}

@export var state:Scp522State = Scp522State.DORMANT:
	set(val):
		if is_equal_approx(animation_timer, 1):
			animation_timer = -1
		else:
			animation_timer = 1
		state = val
@export var body_to_process: Node3D

var animation_timer: int = 0.0

var timer: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if state == Scp522State.ACTIVE:
		timer += delta
		match animation_timer:
			1:
				$Armature/Skeleton3D/CopyTransformModifier3D.active = true
				if $Armature/Skeleton3D/CopyTransformModifier3D.influence < 0.9990234375 && timer < 1.0:
					$Armature/Skeleton3D/CopyTransformModifier3D.influence = timer
				else:
					$Armature/Skeleton3D/CopyTransformModifier3D.influence = 1.0
			-1:
				if $Armature/Skeleton3D/CopyTransformModifier3D.influence > 0.0009765625 && timer < 1.0:
					$Armature/Skeleton3D/CopyTransformModifier3D.influence = 1.0 - timer
				else:
					$Armature/Skeleton3D/CopyTransformModifier3D.influence = 0.0
					$Armature/Skeleton3D/CopyTransformModifier3D.active = false
		
		if body_to_process != null:
			if body_to_process is MovableNpc:
				if int(timer) % 8 == 0:
					body_to_process.health_manage(-10.0)
		elif timer > 10.0:
			state = Scp522State.DORMANT
			timer = 0.0

func _on_scp_522_trigger_body_entered(body: Node3D) -> void:
	state = Scp522State.ACTIVE
	body_to_process = body
	if body is MovableNpc:
		body.movement_freeze = true
