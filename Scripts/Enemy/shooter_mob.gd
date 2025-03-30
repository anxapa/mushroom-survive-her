extends Enemy
const bullet = preload("res://Scenes/Enemy/Shooter Bullet.tscn")
func _ready() -> void:
	super()
	contact_damage = 1

func _physics_process(delta: float) -> void:
	if not (player.global_position - global_position).length() < 400:
		super(delta)
	else:
		move_and_shoot(delta)
		
func make_brute() -> void:
	pass

func move_and_shoot(delta: float) -> void:
	pass
	
	
