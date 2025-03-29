extends Node
class_name GameManager

@export var player : CharacterBody2D

func get_player_position() -> Vector2:
	return player.global_position
