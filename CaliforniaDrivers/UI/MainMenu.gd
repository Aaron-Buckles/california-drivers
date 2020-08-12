extends Control


func _ready():
	var high_score_label = $VBoxContainer/HighScoreLabel
	var high_score: int = HighScoreManager.load_high_score()
	high_score_label.text = "%07d" % high_score


func _on_PlayButton_pressed():
	get_tree().change_scene("res://World/World.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
