extends Panel
class_name LevelUpPanel

@export var ability_manager : AbilityManager
var available_abilities : Array

@onready var buttons : Array[Button] = [
	$"VBoxContainer/VSeparator/AbilityContainer/Ability Choice 1",
	$"VBoxContainer/VSeparator/AbilityContainer/Ability Choice 2",
	$"VBoxContainer/VSeparator/AbilityContainer/Ability Choice 3",
]

var button_choices : Array[int]

func _ready() -> void:
	SignalBus.player_levelup.connect(_on_player_levelup)
	buttons[0].button_down.connect(_choice_button_1_down)
	buttons[1].button_down.connect(_choice_button_2_down)
	buttons[2].button_down.connect(_choice_button_3_down)
	
	for button in buttons:
		button.disabled = false

func get_available_abilities() -> void:
	available_abilities.clear()
	for ability in ability_manager.ability_levels:
		if ability_manager.ability_levels[ability] < 5:
			available_abilities.append(ability)

func assign_button_choices() -> void:
	button_choices.clear()
	while available_abilities and button_choices.size() < 3:
		var random = randi_range(0, available_abilities.size() - 1)
		button_choices.push_back(available_abilities.pop_at(random))
	
	while button_choices.size() < 3:
		button_choices.push_back(-1)

func assign_button_text() -> void:
	for i in 3:
		var button = buttons[i]
		var label = button.get_child(1) as Label
		if button_choices[i] != -1:
			label.text = ability_manager.ability_names[button_choices[i]]
		else:
			label.text = "None"

func resume() -> void:
	visible = false
	get_tree().paused = false

func _on_player_levelup() -> void:
	visible = true
	get_available_abilities()
	assign_button_choices()
	assign_button_text()
	
	get_tree().paused = true

func _choice_button_1_down() -> void:
	if button_choices[0] == -1:
		buttons[0].disabled = true
	else:
		var ability := button_choices[0]
		ability_manager.add_ability(ability)
		resume()

func _choice_button_2_down() -> void:
	if button_choices[1] == -1:
		buttons[1].disabled = true
	else:
		var ability := button_choices[1]
		ability_manager.add_ability(ability)
		resume()

func _choice_button_3_down() -> void:
	if button_choices[2] == -1:
		buttons[2].disabled = true
	else:
		var ability := button_choices[2]
		ability_manager.add_ability(ability)
		resume()
