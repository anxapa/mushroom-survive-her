extends Node2D
class_name Bullet

var direction := Vector2(-1, 0)

# Variables related to how long the bullet is in flight before deleting it.
var is_idle := true
var idle_time := 0.0
@export var idle_time_before_deletion := 8.0

@export var speed := 100
@export var damage_amount := 1.0
@export_enum("Player", "Enemy") var bullet_owner: String
@onready var _area2D = $Area2D

func _ready() -> void:
	_area2D.connect("body_entered", _on_body_entered)

func _process(delta: float) -> void:
	movement(delta)
	idling(delta)

## Handles removing the bullet if it is idle.
func idling(delta: float) -> void:
	if idle_time < idle_time_before_deletion:
		idle_time += delta
	else:
		speed = lerp(speed, 0, 0.02)
		if not speed:
			queue_free()

# Basic movement that moves straight in one direction.
# For more complex movements, override this function with the new one.
func movement(delta) -> void:
	global_position += direction * speed * delta

## Used for setting the correct orientation of the sprite & for direction of movement.
func set_direction(angle: Vector2) -> void:
	direction = angle.normalized()
	rotation = Vector2(-1,0).angle_to(direction)

func _on_body_entered(body: Node2D) -> void:
	if bullet_owner == "Enemy" and body is Player:
		(body as Player).take_damage(damage_amount)
		queue_free()
	elif bullet_owner == "Player" and body is Enemy:
		(body as Enemy).take_damage(damage_amount)
		queue_free()
