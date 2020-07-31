class_name Lane
extends Node2D

signal vehicle_reached_destination(vehicle)

onready var origin: Position2D = $StartPosition
onready var destination: Position2D = $EndPosition


func add(vehicle) -> void:
	add_child(vehicle)
	vehicle.global_position = origin.global_position
	vehicle.destination = destination.global_position
	vehicle.connect("destination_reached", self, "_on_vehicle_reached_destination")


func _on_vehicle_reached_destination(vehicle) -> void:
	emit_signal("vehicle_reached_destination", vehicle)
