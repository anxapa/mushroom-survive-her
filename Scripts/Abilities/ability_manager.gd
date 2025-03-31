extends Node2D
class_name AbilityManager

enum {SPORE_SHOT, MUSHROOM_CLOUD, STUN_SPORE, BOOM_SHROOM}
var abilities : Dictionary[int, Ability] = {
	SPORE_SHOT: preload("res://Scenes/Abilities/Spore Shot Ability.tscn").instantiate(),
	MUSHROOM_CLOUD: preload("res://Scenes/Abilities/Mushroom Cloud Ability.tscn").instantiate(),
	STUN_SPORE: preload("res://Scenes/Abilities/Stun Spore Ability.tscn").instantiate(),
	BOOM_SHROOM: preload("res://Scenes/Abilities/Boom Shroom Ability.tscn").instantiate(),
}

var ability_sprites := {
	SPORE_SHOT: null,
	MUSHROOM_CLOUD: null,
	STUN_SPORE: null,
	BOOM_SHROOM: null,
}

var ability_levels := {
	SPORE_SHOT: 0,
	MUSHROOM_CLOUD: 0,
	STUN_SPORE: 0,
	BOOM_SHROOM: 0,
}

var ability_names := {
	SPORE_SHOT: "Spore Shot",
	MUSHROOM_CLOUD: "Mushroom Cloud",
	STUN_SPORE: "Stun Spore",
	BOOM_SHROOM: "Boom Shroom",
}

var current_abilities : Array[int] 

@export var level_up_panel : Panel

func _ready() -> void:
	add_ability(SPORE_SHOT)

## Adds ability to the player.
## If the ability already exists then upgrade it.
func add_ability(ability: int):
	if current_abilities.has(ability):
		upgrade_ability(ability)
	else:
		ability_levels[ability] = 1
		current_abilities.push_back(ability)
		add_child(abilities[ability])

## Upgrades the ability.
func upgrade_ability(ability: int):
	ability_levels[ability] += 1
	var ability_node = get_child(current_abilities.bsearch(ability)) as Ability
	ability_node.upgrade()
