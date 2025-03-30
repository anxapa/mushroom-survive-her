extends Node2D

enum {Spore_Shot, Mushroom_Cloud, Stun_Spore, Boom_Shroom}
var abilities := {
	Spore_Shot: preload("res://Scenes/Abilities/Spore Shot Ability.tscn").instantiate(),
	Mushroom_Cloud: preload("res://Scenes/Abilities/Mushroom Cloud Ability.tscn").instantiate(),
	Stun_Spore: preload("res://Scenes/Abilities/Stun Spore Ability.tscn").instantiate(),
	Boom_Shroom: preload("res://Scenes/Abilities/Boom Shroom Ability.tscn").instantiate()
}

## Adds ability to the player.
## If the ability already exists then upgrade it.
func _ready() -> void:
	#add_ability(abilities[Spore_Shot])
	#add_ability(abilities[Mushroom_Cloud])
	#add_ability(abilities[Stun_Spore])
	add_ability(abilities[Boom_Shroom])

func add_ability(ability: Ability):
	add_child(ability)
	ability.global_position = global_position

## Upgrades the ability.
func upgrade_ability(ability: Ability):
	pass
