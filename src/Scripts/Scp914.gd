extends StaticBody3D
## SCP-914 code
## Actually, this is one of my oldest code, I made this system in Q4 2022.
## Before SCP: Site Online, and any map generator ports for Godot existed...
## I converted Virtual's map generator for Godot in January 2023.
## This code was used in Site Online, but eventually, in 2025 it met a new home - 
## SCP: Containment Procedures.
##
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License

enum Scp914Mode {ROUGH, COARSE, ONE_TO_ONE, FINE, VERY_FINE}

var items_to_refine: Array[Pickable] = []
#var players_to_refine: Array[MovableNpc] = []
var refining: bool = false
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

@export var mode: Scp914Mode = Scp914Mode.ONE_TO_ONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func refine():
	$DoorBlockIn.disabled = false
	$DoorBlockOut.disabled = false
	$AnimationPlayer.play("Armature|Armature|Armature|Armature|Event|Armature|Event|Armatu")
	await get_tree().create_timer(6.0).timeout
	for item in items_to_refine:
		var target_id: int = -1
		match mode:
			Scp914Mode.ROUGH:
				if get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_rough.size() > 0:
					target_id = get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_rough[rng.randi_range(0, get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_rough.size() - 1)]
			Scp914Mode.COARSE:
				if get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_coarse.size() > 0:
					target_id = get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_coarse[rng.randi_range(0, get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_coarse.size() - 1)]
			Scp914Mode.ONE_TO_ONE:
				if get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_one_to_one.size() > 0:
					target_id = get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_one_to_one[rng.randi_range(0, get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_one_to_one.size() - 1)]
			Scp914Mode.FINE:
				if get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_fine.size() > 0:
					target_id = get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_fine[rng.randi_range(0, get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_fine.size() - 1)]
			Scp914Mode.VERY_FINE:
				if get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_very_fine.size() > 0:
					target_id = get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_very_fine[rng.randi_range(0, get_tree().root.get_node("Game").gamedata.items[item.item_id].upgrade_very_fine.size() - 1)]
		if target_id != -1:
			var result_item: Pickable = load(get_tree().root.get_node("Game").gamedata.items[target_id].pickable_path).instantiate()
			result_item.position = $OutputSpawner.global_position
			get_tree().root.get_node("Game/Items").add_child(result_item)
		item.queue_free()
	await get_tree().create_timer(6.0).timeout
	$DoorBlockOut.disabled = true
	$DoorBlockIn.disabled = true


func _on_add_items_area_body_entered(body: Node3D) -> void:
	items_to_refine.append(body)


func _on_add_items_area_body_exited(body: Node3D) -> void:
	items_to_refine.erase(body)
