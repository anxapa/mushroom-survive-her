extends RigidBody2D

class_name Enemy
@export var max_health := 6.0
@export var speed = 300.0
@export var nutrient_point := 1.0

var base_speed = speed

var can_move := true
var resolution = DisplayServer.window_get_size()
var current_health := max_health
var player = GameManager.get_player()
var contact_damage

func _ready() -> void:
	var angle = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var closeness = 1.5 - randf_range(0, 1)
	# multiplies a point on the unit circle by the viewport's diagonal
	# divides by a closeness factor and centers it on the player
	global_position = angle * resolution.length()/closeness + player.global_position

func _physics_process(delta: float) -> void:
	if can_move:
		global_position = global_position.move_toward(player.global_position, speed * delta)
	
func take_damage(damage: float) -> void:
	current_health -= damage
	
	if current_health <= 0:
		_on_enemy_death()

func paralyze(time: float) -> void:
	can_move = false
	modulate = Color.GREEN
	
	await get_tree().create_timer(time).timeout
	
	can_move = true
	modulate = Color.WHITE

func _on_enemy_death() -> void:
	SignalBus.spawn_nutrient.emit(nutrient_point, global_position)
	queue_free()
