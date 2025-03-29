extends Node

var player : CharacterBody2D

func get_player() -> CharacterBody2D:
	return player

func set_player(playerBody: CharacterBody2D):
	player = playerBody
