extends RigidBody3D
## Created by Yni, licensed under MIT License
class_name Pickable

@export var item_id: int
## Leave this FALSE in inspector - needed only for anti-dupe
@export var picked: bool = false
