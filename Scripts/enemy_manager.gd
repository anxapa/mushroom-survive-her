extends Node2D
var player = GameManager.get_player()
const ant = preload("res://scenes/Enemy/ant_mob.tscn")

func _ready() -> void:
	spawn_mob()
	
func _physics_process(delta: float) -> void:
	pass
	
func spawn_mob() -> void:
	for n in 10:
		var ant = ant.instantiate()
		add_child(ant)
	
