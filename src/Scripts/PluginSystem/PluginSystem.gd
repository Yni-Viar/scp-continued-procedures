extends Node

var lua_state = LuaState.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Should be safe
	lua_state.open_libraries(\
		LuaState.LUA_BASE | \
		LuaState.LUA_PACKAGE | \
		LuaState.LUA_COROUTINE| \
		LuaState.LUA_STRING | \
		LuaState.LUA_MATH | \
		LuaState.LUA_TABLE | \
		LuaState.LUA_DEBUG | \
		LuaState.LUA_UTF8 | \
		LuaState.GODOT_CLASSES | \
		LuaState.GODOT_LOCAL_PATHS)

func execute_plugin_script(file_path: String):
	lua_state.do_file(file_path)
