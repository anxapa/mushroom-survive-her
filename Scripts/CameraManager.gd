extends Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_position = GameManager.get_player_position()
	# Clamps the global position of the camera with the tileset's max / min.
	global_position.x = clamp(player.global_position.x, min.x + 960, max.x - 960)
	global_position.y = clamp(player.global_position.y, min.y + 540, max.y - 540)
