extends Node2D
class_name Ability

@export var is_activable : bool

var upgrade_level := 1
@export var max_upgrade_level : int

var current_cooldown_time : float
@export var cooldown : float

## Upgrades the ability.
func upgrade() -> void:
	if upgrade_level + 1 > max_upgrade_level:
		print("SOMETHING IS FUCKING WRONG PLEASE STOP")
	upgrade_level += 1;
