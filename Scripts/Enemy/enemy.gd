extends RigidBody2D

class_name Enemy
@export var max_health := 6.0
@export var speed = 250.0
@export var nutrient_point := 1.0

# sprites should be defined in each enemy subclass
var tank_sprite
var brute_sprite
var rogue_sprite

var base_speed = speed

var can_move := true
var resolution = DisplayServer.window_get_size()
var current_health := max_health
var player = GameManager.get_player()
@onready var move_target = player.global_position
var contact_damage

func _ready() -> void:
	var angle = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var closeness = 1.5 - randf_range(0, 1)
	# multiplies a point on the unit circle by the viewport's diagonal
	# divides by a closeness factor and centers it on the player
	global_position = angle * resolution.length()/closeness + player.global_position

func _physics_process(delta: float) -> void:
	if can_move:
		global_position = global_position.move_toward(move_target, speed * delta)
	move_target = player.global_position

func take_damage(damage: float) -> void:
	current_health -= damage
	
	if current_health <= 0:
		_on_enemy_death()
	
	# Flash red on hit
	modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE

func _on_enemy_death() -> void:
	SignalBus.enemy_death.emit(nutrient_point, global_position)
	queue_free()
	
func make_brute() -> void:
	contact_damage *= 2

func make_rogue() -> void:
	base_speed *= 1.2
	speed = base_speed
	
func make_tank() -> void:
	max_health *= 1.5
	current_health = max_health

func paralyze(time: float) -> void:
	can_move = false
	modulate = Color.GREEN
	
	await get_tree().create_timer(time).timeout
	
	can_move = true
	modulate = Color.WHITE
