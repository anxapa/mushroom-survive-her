extends Panel

func _ready() -> void:
	SignalBus.player_win.connect(_on_player_win)

func _on_player_win() -> void:
	visible = true
	get_tree().paused = true

func _on_retry_button_button_down() -> void:
	get_tree().reload_current_scene()

func _on_exit_button_button_down() -> void:
	get_tree().quit()
