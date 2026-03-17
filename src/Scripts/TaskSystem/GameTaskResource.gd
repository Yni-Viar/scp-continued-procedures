extends Resource
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License
class_name GameTaskResource

## Internal name
@export var internal_name: String = ""
## Name, that will be displayed
@export var public_name: String = ""
## Required groups
@export var required_groups: Array[String] = []
## Sub tasks, if exist.
@export var sub_tasks: Array[GameTaskResource] = []
