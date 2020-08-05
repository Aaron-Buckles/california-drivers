extends Node2D

signal vehicle_reached_destination(vehicle)
signal vehicle_collision_occurred(vehicle1, vehicle2)

export(int) var min_spawn_time = 0.3

var _lanes: Array = []
var _index: int = 0
var _id: int = 1

onready var Vehicle = preload("res://Vehicles/Vehicle.tscn")
onready var spawn_timer: Timer = $SpawnTimer


func _ready():
	randomize()
	
	for lane in get_children():
		if lane is Lane:
			_lanes.append(lane)
			lane.connect("vehicle_reached_destination", self, "_on_vehicle_reached_destination")
			lane.connect("vehicle_collision_occurred", self, "_on_vehicle_collision_occurred")


func spawn_vehicle() -> void:
	if not _lanes.empty():
		# Choose the lane
		var lane: Lane = _lanes[_index]
		_index += 1
		if _index >= len(_lanes):
			_index = 0
		
		# Spawn the the vehicle
		var vehicle = Vehicle.instance()
		lane.add(vehicle)
		vehicle.id = _id
		_id += 1


func _on_vehicle_reached_destination(vehicle) -> void:
	emit_signal("vehicle_reached_destination", vehicle)
	vehicle.queue_free()


func _on_vehicle_collision_occurred(vehicle1, vehicle2) -> void:
	emit_signal("vehicle_collision_occurred", vehicle1, vehicle2)
	print("COLLISION")


func _on_SpawnTimer_timeout():
	spawn_vehicle()


func _on_DifficultyTimer_timeout():
	if spawn_timer.wait_time > min_spawn_time:
		spawn_timer.wait_time -= 0.1
