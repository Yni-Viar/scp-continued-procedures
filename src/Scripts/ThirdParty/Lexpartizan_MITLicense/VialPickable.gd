@tool
extends Pickable
class_name VialPick

const spring_constant: float = 200
const reaction: float = 4
const dampening: float = 3

@export_range(0.0, 1.0, 0.001) var liquid_mobility: float = 0.0
@export var mesh_with_liquid: MeshInstance3D:
	set(val):
		if val == null:
			print("The mesh is missing.")
			set_physics_process(false)
		elif val.mesh.surface_get_material(0) is ShaderMaterial:
			set_physics_process(true)
			material_pass = val.mesh.surface_get_material(0)
		mesh_with_liquid = val

@export_range(-0.5, 0.5, 0.001) var liquid_size: float:
	set(val):
		if is_physics_processing():
			var mesh_size: Vector3 = mesh_with_liquid.mesh.get_aabb().size
			material_pass.set_shader_parameter("size", Vector2(val * mesh_size.x, val * mesh_size.y))
		liquid_size = val

@onready var pos1: Vector3 = get_global_transform().origin
@onready var pos2: Vector3 = pos1
@onready var pos3: Vector3 = pos2

var vel:float =0.0
var accell : Vector2
var size: Vector3

var coeff : Vector2
var coeff_old : Vector2
var coeff_old_old : Vector2

var material_pass: ShaderMaterial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if material_pass == null:
		return
	var accell_3d:Vector3 = (pos3 - 2 * pos2 + pos1) / delta / delta
	pos1 = pos2
	pos2 = pos3
	pos3 = global_position + rotation
	accell = Vector2(accell_3d.x+accell_3d.y, accell_3d.z+accell_3d.y)
	#accell = Vector2(accell_3d.x, accell_3d.z)
	coeff_old_old = coeff_old
	coeff_old = coeff
	#coeff = delta*delta* (-200.0*coeff_old - 10.0*accell) + 2 * coeff_old - coeff_old_old - delta * 2.0 * (coeff_old - coeff_old_old)
	coeff = delta*delta* (-spring_constant*coeff_old - reaction*accell) + 2 * coeff_old - coeff_old_old - delta * dampening * (coeff_old - coeff_old_old)
	var temp: Vector2 = coeff+coeff_old+coeff_old_old
	material_pass.set_shader_parameter("coeff", coeff*liquid_mobility)
	if (pos1.distance_to(pos3) < 0.01):
		vel = clamp (vel-delta*1.0,0.0,1.0)
	else:
		vel = 1.0#clamp (vel+delta*1.0,0.0,1.0)
	material_pass.set_shader_parameter("vel", vel)
