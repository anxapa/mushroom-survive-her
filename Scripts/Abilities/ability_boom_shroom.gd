extends Ability

@export var damage := 1.0
@export var explosion_range := 100
@export var range := 200
@onready var _area2D := $Area2D

const bullet_scene = preload("res://Scenes/Abilities/Boom Shroom Bullet.tscn")

func _ready():
	change_range(range)

func activate_ability() -> void:
	check_bodies()

## Selects enemy closest to player to shoot to.
func check_bodies() -> void:
	var bodies : Array[Node2D] = _area2D.get_overlapping_bodies()
	var min_distance := 1e99
	var min_distance_enemy : Node2D
	
	if not bodies:
		return
	
	# Finds enemy with the least distance to the player.
	for body in bodies:
		if body is Enemy:
			var distance := global_position.distance_to(body.global_position)
			if distance < min_distance:
				min_distance = distance
				min_distance_enemy = body
	
	# Does not shoot if there are no bodies nearby.
	if min_distance_enemy:
		shoot(min_distance_enemy)

func change_range(range_radius: float) -> void:
	$Area2D/CollisionShape2D.shape.radius = range_radius

## Shoots an enemy.
func shoot(enemy: Node2D) -> void:
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.global_position = global_position
	bullet.damage_amount = damage
	bullet.explosion_range = explosion_range
	bullet.set_direction(enemy.global_position - global_position)
	
func change_level(level: int) -> void:
	match level:
		1:
			cooldown = 2.5
		2:
			damage *= 2
		3:
			explosion_range = range * 1.3/1
		4:
			damage *= 2
		5:
			cooldown -= 0.5
			
