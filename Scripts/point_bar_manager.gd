extends VBoxContainer

@onready var player : Player = GameManager.get_player()
@onready var hp_bar := $"HP Bar"
@onready var hp_text := $"HP Bar/HP Text"
@onready var np_bar := $"NP Bar"
@onready var np_text := $"NP Bar/NP Text"

func _process(delta: float) -> void:
	hp_bar.max_value = player.max_health
	hp_bar.value = player.health
	hp_text.text = str(player.health) + " / " + str(player.max_health)
	
	np_bar.max_value = player.nutrient_till_next_level
	np_bar.value = player.nutrient_points
	np_text.text = str(player.nutrient_points) + " / " + str(player.nutrient_till_next_level)
