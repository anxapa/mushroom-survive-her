extends Node2D
class_name Ability

var is_activable : bool
var upgrade_level := 1
var max_upgrade_level : int
var cooldown : float
var current_cooldown_time : float

## Upgrades the ability.
func upgrade() -> void:
	if upgrade_level + 1 > max_upgrade_level:
		print("SOMETHING IS FUCKING WRONG PLEASE STOP")
	upgrade_level += 1;
