extends Node
## Status effect System
## Created by Yni, licensed under MIT License
class_name StatusEffectManager

## A copy of status effects, defined in game data resource.
var status_effects = null
## Applied status effects.
@export var current_status_effects: Array[Array]

func _ready() -> void:
	status_effects = get_tree().root.get_node("Game").gamedata.status_effects

## Apply status effects
func apply_status_effect(effect: String, strength: float, duration: float):
	# If there is no status effects or this effect is already applied - do nothing.
	if status_effects == null || !status_effects.keys().has(effect):
		return
	# Check if effect is applied
	var index: int = get_status_effect_index(effect)
	if index == -1:
		current_status_effects.append([effect, strength, duration])
		index = current_status_effects.size() - 1
	# There is a Start call trigger.
	for effect_method in status_effects[current_status_effects[index][0]].start_command:
		if (effect_method.player_only && get_parent().is_player) || !effect_method.player_only:
			get_parent()._call_function(effect_method.action_node_path, effect_method.action_method_name, [status_effects[current_status_effects[index][0]].effect_name, strength])
	# If strength is 0.0 - remove effect.
	if is_zero_approx(strength):
		remove_status_effect(index)
		return
	# If duration is more than 0.375 - remove effect after this time.
	if duration >= 0.375:
		await get_tree().create_timer(duration).timeout
		remove_status_effect(index)

## Remove status effect
func remove_status_effect(index: int):
	# If there is wrong index - do nothing.
	if index >= current_status_effects.size() || index < 0:
		return
	# There is a Delete call trigger.
	for effect_method in status_effects[current_status_effects[index][0]].destroy_command:
		get_parent()._call_function(effect_method.action_node_path, effect_method.action_method_name, [status_effects[current_status_effects[index][0]].effect_name, 0.0])
	current_status_effects.remove_at(index)

## Returns current_status_effects index if effect exist, else -1
func get_status_effect_index(effect: String) -> int:
	var index: int = 0
	for effects_check in current_status_effects:
		if effects_check.has(effect):
			return index
		else:
			index += 1
	return -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# There is a Process call trigger.
	if !current_status_effects.is_empty():
		for index in range(current_status_effects.size()):
			for effect_method in status_effects[current_status_effects[index][0]].update_command:
				get_parent()._call_function(effect_method.action_node_path, effect_method.action_method_name, [status_effects[current_status_effects[index][0]].effect_name, current_status_effects[index][1]])
