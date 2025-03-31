extends Area2D
class_name Pickup

var is_near_player := false
var suction_speed := 5.0
@onready var player := GameManager.get_player()

func _process(delta: float) -> void:
	if is_near_player:
		home_to_player(delta)

func home_to_player(delta:float) -> void:
	var target_position = player.global_position
	global_position = global_position.lerp(target_position, suction_speed * delta)

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_near_player = true

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_near_player = false
