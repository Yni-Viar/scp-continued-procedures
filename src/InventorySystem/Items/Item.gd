extends Resource
## Made by Yni, licensed under CC0.
class_name Item

enum Usage {NORMAL, ONE_TIME, ONE_TIME_DROP}

@export var id: int = 0
@export var name: String = ""
@export var texture_tiled: Texture2D = null
@export var pickable_path: String = ""
@export var pickup_sound_path: String = ""
@export var size: Vector2i = Vector2i.ZERO
@export var one_time_use: bool
@export var usage: Usage = Usage.NORMAL
@export_group("Command")
@export var action_node_path: String = ""
@export var action_method_name: String = ""
@export var action_args: Array = []
@export_group("Status effects")
@export var status_effect: String = ""
@export var status_effect_strength: float = 1.0
@export var status_effect_duration: float = 0.0
@export var status_effect_destroyable: bool = true
@export_group("SCP-914")
@export var upgrade_rough: Array[int] = []
@export var upgrade_coarse: Array[int] = []
@export var upgrade_one_to_one: Array[int] = []
@export var upgrade_fine: Array[int] = []
@export var upgrade_very_fine: Array[int] = []
