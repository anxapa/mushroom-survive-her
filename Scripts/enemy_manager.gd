extends Node2D
var player = GameManager.get_player()
var base_frequency := 5.0
# time elapsed in seconds
var time_elasped := 0.0
var can_spawn := true
const ant = preload("res://scenes/Enemy/ant_mob.tscn")

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if can_spawn:
		spawn_mob()
	time_elasped += delta
	
func spawn_mob() -> void:
	can_spawn = false
	for n in 1:
		var ant = ant.instantiate()
		add_child(ant)
	await get_tree().create_timer(base_frequency).timeout
	can_spawn = true
