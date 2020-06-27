extends Node2D

signal vehicle_reached_destination(vehicle)

var _lanes: Array = []

onready var Vehicle = preload("res://Vehicles/Vehicle.tscn")


func _ready():
	randomize()
	
	for lane in get_children():
		if lane is Lane:
			_lanes.append(lane)
			lane.connect("vehicle_reached_destination", self, "_on_vehicle_reached_destination")


func spawn_vehicle() -> void:
	if not _lanes.empty():
		var vehicle = Vehicle.instance()
		var lane: Lane = _lanes[rand_range(0, len(_lanes))]
		lane.add(vehicle)


func _on_vehicle_reached_destination(vehicle) -> void:
	emit_signal("vehicle_reached_destination", vehicle)
	vehicle.queue_free()


func _on_Timer_timeout():
	spawn_vehicle()
