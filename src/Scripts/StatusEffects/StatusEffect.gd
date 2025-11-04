extends Resource
class_name StatusEffect
## Status effect System
## Created by Yni, licensed under MIT License

@export var effect_name: String = ""
@export var start_command: Array[StatusEffectCommand]
@export var update_command: Array[StatusEffectCommand]
@export var destroy_command: Array[StatusEffectCommand]
