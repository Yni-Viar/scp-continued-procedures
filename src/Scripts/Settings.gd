extends Node
## Made by Yni, licensed under MIT License.

## Stages of the developing
enum Stages {release, testing, dev}
enum ItemType {item, map_object, npc}

signal settings_saved

## Migrated from Globals.
## Game's data compatibility for modding.
const DATA_COMPATIBILITY: String = "2.0.0"
## Migrated from Globals.
## Game's data compatibility for modding.
const CURRENT_STAGE: Stages = Stages.dev
## If we don't specify regions, which have additional legal requirements, we are in trouble.
const LEGAL_REQ_REGIONS: PackedStringArray = ["ru_RU"]
## Touchscreen check
var touchscreen: bool = false
## Settings resource
var setting_res: SettingsResource

var paused_game = false
## If we don't specify regions, which have additional legal requirements, we are in trouble.
var region: String = "":
	set(val):
		region = val
		legal_req = is_legal_req()
var legal_req: bool = false

func _init():
	load_resource()
	audio_settings(1, setting_res.music_volume)

## Sometimes ago it was a great function. Now it is just a stub, that calls ResourceStorage and loads settings
func load_resource():
	if OS.get_name() != "Web":
		var settings_from_file = ResourceStorage.load_resource("user://Settings.bin", "SettingsResource")
		if settings_from_file != null:
			setting_res = settings_from_file
		else:
			load_default_settings()
	else:
		load_default_settings()

func load_default_settings():
	#if OS.get_name() != "Web" || OS.get_name() != "Android":
	var res = load("res://Scripts/SettingsResource/Presets/OpenGL/Low.tres")
	save_resource(res)
	setting_res = res
	#else:
		#var res = load("res://Scripts/SettingsResource/Presets/OpenGL/Lowest.tres")
		#save_resource(res)
		#setting_res = res

## Sometimes ago it was a great function. Now it is just a stub, that calls ResourceStorage and saves settings
func save_resource(res):
	if OS.get_name() != "Web":
		ResourceStorage.save_resource("user://Settings.bin", res)
		emit_signal("settings_saved")

func is_legal_req() -> bool:
	return LEGAL_REQ_REGIONS.has(region)

## https://docs.godotengine.org/en/latest/tutorials/scripting/pausing_games.html comment by Spekel
func set_pause_subtree(pause: bool) -> void:
	var process_setters = ["set_process",
	"set_physics_process",
	"set_process_input",
	"set_process_unhandled_input",
	"set_process_unhandled_key_input",
	"set_process_shortcut_input",]
	
	for setter in process_setters:
		get_tree().root.propagate_call(setter, [!pause])
	Engine.time_scale = 0.01 if pause else 1.0
	paused_game = pause

func audio_settings(bus: int, val: float):
	AudioServer.set_bus_volume_db(bus, linear_to_db(val))
	if val < 0.01:
		AudioServer.set_bus_mute(bus, true)
	elif val >= 0.01 && AudioServer.is_bus_mute(bus):
		AudioServer.set_bus_mute(bus, false)	

func override_main_scene(scene: Node):
	get_tree().current_scene = scene
