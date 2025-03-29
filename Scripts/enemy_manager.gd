extends Node2D
var resolution = Vector2(1920, 1080)
var player = GameManager.get_player()

func _ready() -> void:
	pass
	
func spawn_mob() -> void:
	var angle = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	var spawn_position = angle*resolution.dot(resolution)
	
