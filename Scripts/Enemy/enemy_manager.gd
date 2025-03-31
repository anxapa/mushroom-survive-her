extends Node2D

var player = GameManager.get_player()
var base_frequency := 9.0
# time elapsed in seconds
var time_elapsed := 0.0
var can_spawn := true
var difficulty = 1
var cluster_size := 2
var ant = load("res://Scenes/Enemy/ant_mob.tscn")
var charger = load("res://Scenes/Enemy/charger_mob.tscn")
var shooter = load("res://Scenes/Enemy/shooter_mob.tscn")
const minute := 60.0
var enemies = []

func _ready() -> void:
	mob_change(1, 0, 0)
	for n in 5:
		spawn_mob()
	
func _physics_process(delta: float) -> void:
	if can_spawn:
		spawn_mob()
	time_elapsed += delta
	if int(time_elapsed)/60 >= difficulty:
		print("test")
		difficulty_change()
		
func spawn_mob() -> void:
	can_spawn = false
	for n in cluster_size:
		var enemy = enemies.pick_random()
		enemy = enemy.instantiate()
		add_child(enemy)
		if difficulty >= 4:
			make_variant(enemy)
	await get_tree().create_timer(base_frequency - 0.5*difficulty).timeout
	can_spawn = true
	
func make_variant(enemy: Enemy) -> void:
	if randf_range(difficulty, 20)/2 > 0.5:
		match randi_range(1, 3):
			1:
				enemy.make_brute()
			2:
				enemy.make_rogue()
			3:
				enemy.make_tank()
				
## arguments determine spawn ratios.
## i.e. mob_change(1, 1, 1) is a uniform distribution.
func mob_change(ant: int, charger: int, shooter: int) -> void:
	enemies.clear()
	for n in ant:
		enemies.push_back(self.ant)
	for n in charger:
		enemies.push_back(self.charger)
	for n in shooter:
		enemies.push_back(self.shooter)
	
func difficulty_change() -> void:
	difficulty += 1
	match difficulty:
		2:
			mob_change(2, 1, 0)
			cluster_size += 2
		3:
			cluster_size += 2
			mob_change(4, 5, 0)
		4:
			await get_tree().create_timer(10).timeout
			mob_change(1, 0, 0)
		5:
			mob_change(1, 0, 0)
			await get_tree().create_timer(10).timeout
			mob_change(1, 1, 0)
		6:
			mob_change(1, 0, 1)
			await get_tree().create_timer(10).timeout
			mob_change(1, 1, 1)
		7:
			mob_change(1, 1, 2)
		8:
			mob_change(1, 2, 2)
		9:
			mob_change(1, 2, 2)
		10:
			mob_change(1, 1, 1)
	
