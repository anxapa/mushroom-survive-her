extends Ability

# Some ability components are set in the inspector.

@export var paralyze_time := 2.0
@onready var _area_2D := $Area2D

func activate_ability() -> void:
	print("AAAA")
	var bodies : Array[Node2D] = _area_2D.get_overlapping_bodies()
	for body in bodies:
		if body is Enemy:
			print("Enemy Paralyzed")
			var enemy = body as Enemy
			enemy.paralyze(paralyze_time)
