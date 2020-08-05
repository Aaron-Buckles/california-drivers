class_name Lane
extends Node2D

signal vehicle_reached_destination(vehicle)
signal vehicle_collision_occurred(vehicle1, vehicle2)

onready var origin: Position2D = $StartPosition
onready var destination: Position2D = $EndPosition


func add(vehicle) -> void:
	add_child(vehicle)
	vehicle.global_position = origin.global_position
	vehicle.destination = destination.global_position
	vehicle.connect("destination_reached", self, "_on_vehicle_reached_destination")
	vehicle.connect("collision_occurred", self, "_on_vehicle_collision_occurred")


func _on_vehicle_reached_destination(vehicle) -> void:
	emit_signal("vehicle_reached_destination", vehicle)


func _on_vehicle_collision_occurred(vehicle1, vehicle2) -> void:
	emit_signal("vehicle_collision_occurred", vehicle1, vehicle2)
