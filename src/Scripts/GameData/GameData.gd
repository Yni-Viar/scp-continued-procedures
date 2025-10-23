extends Resource
## Class data.
## Made by Yni, licensed under MIT license.
class_name GameData
## Puppet class, that will be used by the player
@export var player_class: Array[PuppetClass] = []
## Puppet class
@export var puppet_classes: Array[PuppetClass] = []
## Tasks to do.
@export var tasks: Array[GameTaskResource] = []
## All items.
@export var items: Array[Item] = []
## Wave puppets
@export var wave_puppet_classes: Array[PuppetClass] = []
## Custom left Scientist's offices (available since v4.0)
@export var custom_left_scientists_offices: Array[PackedScene] = []
## Custom right Scientist's offices (available since v4.0)
@export var custom_right_scientists_offices: Array[PackedScene] = []
## Status Effects
@export var status_effects: Dictionary[String, StatusEffect] = {}
