extends Ability

# Some ability components are set in the inspector.

@export var paralyze_time := 2.0
@onready var _area_2D := $Area2D

func activate_ability() -> void:
	var bodies : Array[Node2D] = _area_2D.get_overlapping_bodies()
	for body in bodies:
		if body is Enemy:
			var enemy = body as Enemy
			enemy.paralyze(paralyze_time)

func change_level(level: int) -> void:
	match level:
		1:
			cooldown = 5
		2:
			paralyze_time += 1
		3:
			cooldown -= 1
		4:
			cooldown -= 0.5
		5:
			paralyze_time += 0.5
