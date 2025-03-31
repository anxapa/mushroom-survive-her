extends Node2D

const nutrient_scene = preload("res://Scenes/Pickups/nutrient.tscn")
const mystealium_scene = preload("res://Scenes/Pickups/Mystealium.tscn")

func _ready() -> void:
	SignalBus.enemy_death.connect(_spawn_nutrient)
	SignalBus.enemy_death.connect(_spawn_pickups)
	
func _spawn_nutrient(point: float, location: Vector2) -> void:
	var nutrient := nutrient_scene.instantiate()
	call_deferred("add_child", nutrient)
	nutrient.nutrient_point = point
	nutrient.global_position = location

func _spawn_pickups(_unused: float, location: Vector2) -> void:
	var random = randf_range(0, 1)
	if random < 0.02:
		var mystealium = mystealium_scene.instantiate()
		call_deferred("add_child", mystealium)
		mystealium.global_position = location
	
