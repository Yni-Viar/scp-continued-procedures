extends Node
## Status effect System
## Created by Yni, licensed under MIT License
class_name StatusEffectManager

var status_effects = null
@export var current_status_effect: String:
	set(val):
		if status_effects != null:
			if status_effects.keys().has(val):
				strength = status_effects[val].strength
				current_status_effect = val
				if !val.is_empty():
					apply_status_effect(val)
			else:
				current_status_effect = ""
		else:
			current_status_effect = ""
@export var strength: float = 0.0

func _ready() -> void:
	status_effects = get_tree().root.get_node("Game").gamedata.status_effects

func apply_status_effect(effect: String):
	if status_effects == null:
		return
	for effect_method in status_effects[effect].start_command:
		get_parent()._call_function(effect_method.action_node_path, effect_method.action_method_name, effect_method.action_args)
	var duration = status_effects[effect].duration
	if duration >= 0.5:
		await get_tree().create_timer(duration).timeout
		current_status_effect = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !current_status_effect.is_empty():
		for effect_method in status_effects[current_status_effect].update_command:
			get_parent()._call_function(effect_method.action_node_path, effect_method.action_method_name, effect_method.action_args)
