extends Node2D
var player = GameManager.get_player()
#var rng = RandomNumberGenerator.new()
var base_frequency := 5.0
# time elapsed in seconds
var time_elapsed := 0.0
var can_spawn := true
@export var cluster_size := 1
const ant = preload("res://scenes/Enemy/ant_mob.tscn")
const charger = preload("res://Scenes/Enemy/charger_mob.tscn")
const shooter = preload("res://Scenes/Enemy/shooter_mob.tscn")
var enemies = [charger]

func _ready() -> void:
	spawn_mob()
func _physics_process(delta: float) -> void:
	if can_spawn:
		spawn_mob()
	time_elapsed += delta
	if time_elapsed > 5 and not enemies.has(charger):
		enemies.push_back(charger)
	pass
		
func spawn_mob() -> void:
	can_spawn = false
	for n in cluster_size:
		var enemy = enemies.pick_random()
		enemy = enemy.instantiate()
		add_child(enemy)
	await get_tree().create_timer(base_frequency).timeout
	can_spawn = true
