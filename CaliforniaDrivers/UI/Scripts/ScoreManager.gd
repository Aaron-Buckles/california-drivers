extends Control


var score: int = 0

onready var label = $Panel/Label


func _on_LaneManager_vehicle_reached_destination(vehicle):
	score += 1
	label.text = "Score: " + str(score)
