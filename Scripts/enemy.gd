extends Area2D

class_name Enemy

var starting_position : Vector2
@export var max_health := 6
var current_health := max_health

func _ready() -> void:
	starting_position = position
	
