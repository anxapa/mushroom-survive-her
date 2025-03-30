extends Node2D
class_name Ability

@export var is_activable : bool

var upgrade_level := 1
@export var max_upgrade_level : int

var current_cooldown_time : float
@export var cooldown : float

func _process(delta: float) -> void:
	# Cooldown handling for activatable abilities.
	if is_activable:
		if current_cooldown_time <= 0:
			activate_ability()
			current_cooldown_time = cooldown
		else:
			current_cooldown_time -= delta

## Upgrades the ability.
func upgrade() -> void:
	if upgrade_level + 1 > max_upgrade_level:
		print("ERROR: Ability upgrade code not overridden.")
	upgrade_level += 1;

## Activates ability if activatable.
func activate_ability() -> void:
	print("ERROR: Ability activation code not overridden.")
