extends Resource
class_name StatusEffect
## Status effect System
## Created by Yni, licensed under MIT License

@export var effect_name: String = ""
@export var strength: float = 0.0
@export var duration: float = 0.0
@export var start_command: Array[StatusEffectCommand]
@export var update_command: Array[StatusEffectCommand]
@export var destroy_command: Array[StatusEffectCommand]
