extends Control


var score: int = 0

onready var score_label = $Score


func _on_LaneManager_vehicle_reached_destination(vehicle):
	score += 1
	score_label.text = "%06d" % score
