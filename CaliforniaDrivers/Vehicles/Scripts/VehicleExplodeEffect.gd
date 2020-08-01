extends AnimatedSprite


func _ready():
	frame = 0
	play("Explode")


func _on_VehicleExplodeEffect_animation_finished():
	queue_free()
