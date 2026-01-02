### `inventory_add_item(item_index: int)`
Adds item to puppet's inventory.

Requires item index.

### `inventory_has_item(item_index: int)`
Check if item is in puppet's inventory.

Requires item index.

### `inventory_take_item(item_index: int)`
Hold an item in hand (humans only).

Requires item index.

### `item_remove_by_id(item_index: int, drop: bool)`
Removes item from inventory.

Requires item index, and drop boolean (will be item dropped or not).

### `health_manage(health_to_add: float, health_type: int = 0)`
Add or deplete health

Require amount of health and health type
(0 is general health, 1 is coldness (humans only),
2 is thirst (humans only), 3 is hunger (humans only))

### `is_player() -> bool`
Check if is actual player and not NPC

### `set_target_follow(path: String)`
Follows target

Use:
`set_target_follow(get_player_by_index(i).get_parent_path())`

where `get_player_by_index(i)` is `PluginApiGeneric` method.

### `set_wandering(enabled: bool)`
Enable or disable wandering.

If enabled, puppet will stop following someone.

### `get_parent_path() -> String`
Gets MovableNpcs path.

### `set_effect(effect_name: String, amount: float, duration: float)`
Sets effect with amount and duration
`amount = 0.0` removes the effect
`duration <= 0.375` makes effect permanent until turned off by `amount = 0.0`

### `call_puppet_model_func(method: String, args: Array)`
Calls puppet model function (only exposed ones)
If there are no args, please, write [] as args variable.

#### Available functions:
**SCP-650:**

`set_scp650_variations(path_array: Dictionary[String, Dictionary])` - Sets SCP-650 skins

Skin format:
```
{
    "path_to_your_gltf, begins with res:// or user://": {
        "CHRISTMAS" / "HALLOWEEN" : {
        	"relative_node_path_string": [
        		[0, "ALBEDO", "path_to_your_retexture, begins with res:// or user://"]
        	]
        }
    }
}
```

`spawn_scp_variation()` - Spawns random SCP variation