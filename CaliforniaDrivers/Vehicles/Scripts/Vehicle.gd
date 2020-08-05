extends Area2D

signal destination_reached(vehicle)
signal collision_occurred(vehicle1, vehicle2)

const VehicleExplodeEffect = preload("res://Vehicles/VehicleExplodeEffect.tscn")

export(float) var max_speed = 30
export(float) var boost_multiplier = 4

var destination: Vector2 = Vector2.ZERO setget set_destination
var id: int = 0 setget set_id, get_id

var _destination_reached = false
var _min_distance = 5
var _velocity = Vector2.ZERO
var _mouse_over = false

onready var _speed = max_speed
onready var sprite: Sprite = $Sprite


func _ready():
	sprite.modulate = Color.from_hsv(randf(), randf(), 0.75, 1)


func _process(delta):
	if _mouse_over:
		if Input.is_action_just_pressed("boost"):
			_speed = max_speed * boost_multiplier
		elif Input.is_action_just_pressed("stop"):
			_speed = 0


func _physics_process(delta):
	if _destination_reached or destination == Vector2.ZERO:
		return
	
	if _check_destination_reached():
		emit_signal("destination_reached", self)
		return
	
	_velocity = global_position.direction_to(destination) * _speed
	position += _velocity * delta
	
	if _speed != 0:
		_set_rotation()


func set_destination(new_destination: Vector2) -> void:
	destination = new_destination


func set_id(new_id: int) -> void:
	if id == 0:
		id = new_id


func get_id() -> int:
	return id


func _check_destination_reached() -> bool:
	var distance = global_position.distance_to(destination)
	if distance < _min_distance:
		_destination_reached = true
	return _destination_reached


func _set_rotation() -> void:
	rotation_degrees = rad2deg(_velocity.angle())


func _on_Vehicle_area_entered(area):
	queue_free()
	
	if id > area.id:
		emit_signal("collision_occurred", self, area)
		var vehicle_explode_effect = VehicleExplodeEffect.instance()
		get_parent().add_child(vehicle_explode_effect)
		var new_x_pos = (global_position.x + area.global_position.x) / 2
		var new_y_pos = (global_position.y + area.global_position.y) / 2
		vehicle_explode_effect.global_position = Vector2(new_x_pos, new_y_pos)


func _on_Vehicle_mouse_entered():
	_mouse_over = true


func _on_Vehicle_mouse_exited():
	_mouse_over = false
