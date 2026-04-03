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
## Custom Scientist's offices (available since v7.0)
@export var custom_scientists_offices: Array[PackedScene] = []
## Status Effects
@export var status_effects: Dictionary[String, StatusEffect] = {}
