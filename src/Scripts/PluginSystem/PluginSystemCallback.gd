extends Node


func _on_game_on_launch() -> void:
	if !DirAccess.dir_exists_absolute("user://plugins/on_start"):
		DirAccess.make_dir_absolute("user://plugins/on_start")
	for dir in DirAccess.get_directories_at("user://plugins/on_start"):
		for filename in DirAccess.get_files_at("user://plugins/on_start/" + dir):
			if filename.ends_with(".lua"):
				PluginSystem.execute_plugin_script("user://plugins/on_start/" + dir + "/" + filename)


func _on_game_on_finish_load() -> void:
	if !DirAccess.dir_exists_absolute("user://plugins/on_finish_load"):
		DirAccess.make_dir_absolute("user://plugins/on_finish_load")
	for dir in DirAccess.get_directories_at("user://plugins/on_finish_load"):
		for filename in DirAccess.get_files_at("user://plugins/on_finish_load/" + dir):
			if filename.ends_with(".lua"):
				PluginSystem.execute_plugin_script("user://plugins/on_finish_load/" + dir + "/" + filename)
