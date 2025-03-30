extends Ability

# Some ability components are set in the inspector.

@export var damage := 20.0
@onready var _area_2D := $Area2D

func activate_ability() -> void:
	var bodies : Array[Node2D] = _area_2D.get_overlapping_bodies()
	for body in bodies:
		if body is Enemy:
			var enemy = body as Enemy
			enemy.take_damage(damage)
