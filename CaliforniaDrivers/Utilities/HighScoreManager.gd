extends Node


const SAVE_PATH = "user://save.dat"


func save(score: int) -> void:
	var high_score: int = load_high_score()
	if score <= high_score:
		return
	else:
		high_score = score
	
	var file = File.new()
	var error = file.open(SAVE_PATH, File.WRITE)
	if error == OK:
		file.store_32(high_score)
		file.close()


func load_high_score() -> int:
	var high_score: int = 0
	var file = File.new()
	if file.file_exists(SAVE_PATH):
		var error = file.open(SAVE_PATH, File.READ)
		if error == OK:
			high_score = file.get_32()
			file.close()
	return high_score
