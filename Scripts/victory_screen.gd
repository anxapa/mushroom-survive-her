extends Panel

func _ready() -> void:
	SignalBus.player_death.connect(_on_player_death)

func _on_player_death() -> void:
	visible = true
	get_tree().paused = true

func _on_retry_button_button_down() -> void:
	get_tree().reload_current_scene()


func _on_exit_button_button_down() -> void:
	get_tree().quit()
