extends Control


var score: int = 0


func _on_LaneManager_vehicle_reached_destination(vehicle):
	print("A vehicle has reached its destination")
	score += 1
	print("Score: " + str(score))
