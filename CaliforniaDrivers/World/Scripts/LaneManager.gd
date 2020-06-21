extends Node2D

signal vehicle_reached_destination(vehicle)

var _lanes: Array = []

onready var Vehicle = preload("res://Vehicles/Vehicle.tscn")


func _ready():
	for lane in get_children():
		if lane is Lane:
			_lanes.append(lane)
			lane.connect("vehicle_reached_destination", self, "_on_vehicle_reached_destination")
	
	spawn_vehicle()


func spawn_vehicle() -> void:
	if not _lanes.empty():
		var vehicle = Vehicle.instance()
		var lane: Lane = _lanes[0]
		lane.add(vehicle)


func _on_vehicle_reached_destination(vehicle) -> void:
	emit_signal("vehicle_reached_destination", vehicle)