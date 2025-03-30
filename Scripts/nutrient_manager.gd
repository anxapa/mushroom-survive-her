extends Node2D

const nutrient_scene = preload("res://Scenes/nutrient.tscn")

func _ready() -> void:
	SignalBus.spawn_nutrient.connect(_spawn_nutrient)
	
func _spawn_nutrient(point: float, location: Vector2) -> void:
	var nutrient := nutrient_scene.instantiate()
	call_deferred("add_child", nutrient)
	nutrient.nutrient_point = point
	nutrient.global_position = location
