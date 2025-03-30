extends Enemy
const bullet_scene = preload("res://Scenes/Enemy/Shooter Bullet.tscn")
var bullet_damage = 1
var cooldown = 0
var cooldown_time = 5
func _ready() -> void:
	super()
	contact_damage = 1

func _physics_process(delta: float) -> void:
	if not (player.global_position - global_position).length() < 400:
		super(delta)
	elif (player.global_position - global_position).length() < 200:
		move_target = -(player.global_position - global_position) + global_position
		super(delta)
	elif cooldown <= 0:
		shoot(delta)
	cooldown -= delta

func make_brute() -> void:
	bullet_damage *= 2

func shoot(delta: float) -> void:
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.global_position = global_position
	bullet.damage_amount = bullet_damage
	bullet.set_direction(player.global_position - global_position)
	cooldown = cooldown_time
	
