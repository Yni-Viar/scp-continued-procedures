extends Node
## Status effect System
## Created by Yni, licensed under MIT License
class_name StatusEffectManager

var status_effects = null
@export var current_status_effects: Array[Array]

func _ready() -> void:
	status_effects = get_tree().root.get_node("Game").gamedata.status_effects

func apply_status_effect(effect: String, strength: float, duration: float):
	if status_effects == null || !status_effects.keys().has(effect):
		return
	var index: int = 0
	var effect_already_applied: bool = false
	for effects_check in current_status_effects:
		if effects_check.has(effect):
			effects_check[1] = strength
			effects_check[2] = duration
			effect_already_applied = true
		else:
			index += 1
	if !effect_already_applied:
		current_status_effects.append([effect, strength, duration])
		index = current_status_effects.size() - 1
	for effect_method in status_effects[current_status_effects[index][0]].start_command:
		get_parent()._call_function(effect_method.action_node_path, effect_method.action_method_name, [status_effects[current_status_effects[index][0]].effect_name, current_status_effects[index][1]])
	if is_zero_approx(strength):
		current_status_effects.remove_at(index)
		return
	if duration >= 0.375:
		await get_tree().create_timer(duration).timeout
		current_status_effects.remove_at(index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !current_status_effects.is_empty():
		for index in range(current_status_effects.size()):
			for effect_method in status_effects[current_status_effects[index][0]].update_command:
				get_parent()._call_function(effect_method.action_node_path, effect_method.action_method_name, [status_effects[current_status_effects[index][0]].effect_name, current_status_effects[index][1]])
