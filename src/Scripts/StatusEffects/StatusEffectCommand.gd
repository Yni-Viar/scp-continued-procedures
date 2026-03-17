extends Resource
## Custom commands script for StatusEffects
## Made by Yni, licensed under MIT License.
class_name StatusEffectCommand

## Which node to trigger function
@export var action_node_path: String = ""
## Method name to call
@export var action_method_name: String = ""
## Is this status effect apply only on player?
@export var player_only: bool = false
