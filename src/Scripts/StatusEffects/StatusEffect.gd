extends Resource
class_name StatusEffect
## Status effect System
## Created by Yni, licensed under MIT License

## Status effect name
@export var effect_name: String = ""
## Command, that will be called, when just applied
@export var start_command: Array[StatusEffectCommand]
## Command, that will be called continously, while in effect.
@export var update_command: Array[StatusEffectCommand]
## Command, that will be called, when terminating effect.
@export var destroy_command: Array[StatusEffectCommand]
