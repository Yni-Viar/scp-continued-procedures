# Enums

> Type of entity
enum EntityType {PUPPET, TASKS, ITEMS}


> Room type, used in `load_new_room()` function
```
enum MapGenRoomType {
	ROOM1 = 0,
	ROOM1SINGLE = 1,
	ROOM1LARGE = 2,
	ROOM2 = 3,
	ROOM2SINGLE = 4,
	ROOM2LARGE = 5, 
	ROOM2C = 6,
	ROOM2CSINGLE = 7,
	ROOM2CLARGE = 8,
	ROOM3 = 10,
	ROOM3SINGLE = 11,
	ROOM3LARGE = 12,
	ROOM4 = 13,
	ROOM4SINGLE = 14}
```

# Functions
## `update_puppets()`
Refreshes player/puppet list

## `get_puppet_by_index(index: int)`
Gets puppet by index
If puppet not found then gets local player

## `spawn_entity(type: EntityType, index: int)`
Spawns entity with selected by index resource.
*As of 6.0.0, only puppets are supported, so the first argument is always 0.*

## `load_new_entity(type: EntityType, path: String)`
Loads new entity to the game (rooms are spawned in separate function - `load_new_room()`)
*As of 6.0.0, only items and tasks are supported, not puppets*
`path` is the path to your `Item` or `GameTaskResource`

## `do_task(task_name: String)`
Do task with specified name.
### Built-in task naming
Built-in task name consist of `task_` and SCP object name, such as `067`, so the final layout is `task_067`
The exception of this rule are SCP-914 tasks, which consist of `task_914_exp_` and a number.

## `re_initialize_tasks(amount: int = 2)`
Re-initialize tasks
As of 6.0.0, this is a workaround for adding new task directly

## `load_new_room(path: String, zone_index: int, room_type: MapGenRoomType)`
Adds new room to the map.
Not compatible with Android devices and can only be an on_launch plugin.
Double and checkpoint rooms are not supported
`path` is the path to your `MapGenRoom`