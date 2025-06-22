extends AnimatableBody3D
## SCP-914 code
## Actually, this is one of my oldest code, I made this system in Q4 2022.
## Before SCP: Site Online, and any map generator ports for Godot existed...
## I converted Virtual's map generator for Godot in January 2023.
## This code was used in Site Online, but eventually, in 2025 it met a new home - 
## SCP: Containment Procedures.
##
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License

enum Scp914Mode {ROUGH, COARSE, ONE_TO_ONE, FINE, VERY_FINE}

var items_to_refine: Array[Pickable] = []
var players_to_refine: Array[MovableNpc] = []
var refining: bool = false

@export var modes: Scp914Mode = Scp914Mode.ONE_TO_ONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func refine():
	$DoorBlockIn.disabled = false
	$DoorBlockOut.disabled = false
	$AnimationPlayer.play("Armature|Armature|Armature|Armature|Event|Armature|Event|Armatu")
	await get_tree().create_timer(12.0).timeout
	$DoorBlockOut.disabled = true
	$DoorBlockIn.disabled = true
