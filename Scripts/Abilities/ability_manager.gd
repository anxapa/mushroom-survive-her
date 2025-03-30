extends Node2D

const spore_shot_ability_scene = preload("res://Scenes/Abilities/Spore Shot Ability.tscn")

## Adds ability to the player.
## If the ability already exists then upgrade it.
func _ready() -> void:
	var spore_shot: Ability = spore_shot_ability_scene.instantiate() 
	add_ability(spore_shot)

func add_ability(ability: Ability):
	add_child(ability)
	ability.global_position = global_position

## Upgrades the ability.
func upgrade_ability(ability: Ability):
	pass
