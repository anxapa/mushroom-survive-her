extends Ability

@onready var _area2D := $Area2D
var range := 200

func _ready():
	cooldown = 0.1
	max_upgrade_level = 5

func _process(delta: float) -> void:
	if current_cooldown_time <= 0:
		check_enemies()

## Selects enemy closest to player to shoot to.
func check_enemies() -> void:
	var enemies : Array[Node2D] = _area2D.get_overlapping_bodies()
	var min_distance := 1e99
	var min_distance_enemy := enemies[0]
	
	# Finds enemy with the least distance to the player.
	for enemy in enemies:
		var distance := global_position.distance_to(enemy.global_position)
		if distance < min_distance:
			min_distance = distance
			min_distance_enemy = enemy
	
	# Does not shoot if there are no enemies nearby.
	if min_distance_enemy:
		shoot(min_distance_enemy)

## Shoots an enemy.
func shoot(enemy: Node2D) -> void:
	pass
