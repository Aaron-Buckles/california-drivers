extends Area2D

signal destination_reached(vehicle)

var destination: Vector2 = Vector2.ZERO setget set_destination

var _destination_reached = false
var _min_distance = 0.1
var _velocity = Vector2.ZERO
var _mouse_over = false

export(float) var speed = 30
export(float) var max_speed = 30
export(float) var acceleration = 100


func _process(delta):
	if _mouse_over:
		if Input.is_action_just_pressed("boost"):
			print("Boosting!!!")
		elif Input.is_action_just_pressed("stop"):
			print("Stopping.")


func _physics_process(delta):
	if _destination_reached or destination == Vector2.ZERO:
		return
	
	if _check_destination_reached():
		emit_signal("destination_reached", self)
		return
	
	_velocity = global_position.direction_to(destination) * max_speed
	position += _velocity * delta
	_set_rotation()


func set_destination(new_destination: Vector2) -> void:
	destination = new_destination


func _check_destination_reached() -> bool:
	var distance = global_position.distance_to(destination)
	if distance < _min_distance:
		_destination_reached = true
	return _destination_reached


func _set_rotation() -> void:
	rotation_degrees = rad2deg(_velocity.angle())


func _on_Vehicle_area_entered(area):
	queue_free()


func _on_Vehicle_mouse_entered():
	print("Mouse entered")
	_mouse_over = true


func _on_Vehicle_mouse_exited():
	_mouse_over = false
