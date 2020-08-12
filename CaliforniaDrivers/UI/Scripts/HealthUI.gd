extends Control


signal health_reached_zero

const HEART_TEXTURE_SIZE = 16

export(int) var health = 3

onready var heart_texture: TextureRect = $HeartTexture


func _ready():
	_update_health_ui()


func _update_health_ui() -> void:
	if health <= 0:
		heart_texture.visible = false
		emit_signal("health_reached_zero")
	else:
		heart_texture.visible = true
		heart_texture.rect_size.x = health * HEART_TEXTURE_SIZE


func _on_LaneManager_vehicle_collision_occurred(vehicle1, vehicle2):
	health -= 1
	_update_health_ui()
