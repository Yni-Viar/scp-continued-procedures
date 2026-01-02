extends Node
## Plugin API for MovableNpc
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License
class_name PluginApiMovableNpc

## Calls puppet model function (only exposed ones)
## If there are no args, please, write [] as args variable.
func call_puppet_model_func(method: String, args: Array):
	if get_parent().get_node("PlayerModel").get_child_or_null(0) != null:
		if get_child(0) is BasePuppetScript:
			get_parent().get_node("PlayerModel").get_child(0).pluginapi_call_method(method, args)

## Adds item to puppet's inventory.
## Requires item index
func inventory_add_item(item_index: int):
	get_parent().get_node("UI/Inventory/Inventory").add_item(item_index)

## Check if item is in puppet's inventory
## Requires item index
func inventory_has_item(item_index: int):
	get_parent().get_node("UI/Inventory/Inventory").has_item(item_index)

## Hold an item in hand (humans only).
## Requires item index.
func inventory_take_item(item_index: int):
	get_parent().action_take(item_index)

## Removes item from inventory
## Requires item index, and drop boolean (will be item dropped or not)
func item_remove_by_id(item_index: int, drop: bool):
	get_parent().get_node("UI/Inventory/Inventory").item_remove_by_id(item_index, drop)

## Add or deplete health
## Require amount of health and health type
## (0 is general health, 1 is coldness (humans only),
## 2 is thirst (humans only), 3 is hunger (humans only))
func health_manage(health_to_add: float, health_type: int = 0):
	get_parent().health_manage(health_to_add, health_type)

## Check if is actual player and not NPC
func is_player() -> bool:
	return get_parent().is_player

## Follows target
## Use:
## set_target_follow(get_player_by_index(i).get_parent_path()),
## where get_player_by_index(i) is PluginApiGeneric method.
func set_target_follow(path: String):
	get_parent().target_follow = path

## Enable or disable wandering
## If enabled, puppet will stop following someone
func set_wandering(enabled: bool):
	get_parent().wandering = enabled

## Sets target position to Vector3
## /!\ Use with caution.
#func set_target_position(target_position: Vector3):
	#get_parent().set_target_position(target_position)

## Gets MovableNpcs path
func get_parent_path() -> String:
	return get_parent().get_path()

## Sets effect with amount
## amount = 0.0 removes the effect
## duration = 0.0 makes effect permanent until turned off by amount = 0.0
func set_effect(effect_name: String, amount: float, duration: float):
	get_parent().get_node("StatusEffects").apply_status_effect(effect_name, amount, duration)
