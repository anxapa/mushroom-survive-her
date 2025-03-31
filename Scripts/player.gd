extends CharacterBody2D
class_name Player

@export var speed := 400
@export var invincible_time := 1.0
var max_health := 10
var health := max_health
var is_invincible := false
var nutrient_points := 0.0
var nutrient_till_next_level := 10.0
var level := 1

func _ready() -> void:
	SignalBus.player_death.connect(_on_player_death)
	GameManager.set_player(self)

func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	
	# Moves in input direction. If no input direction, moves to the zero vector.
	if direction:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
	
	# Sprite and interact area moving depending on the direction of the player
	#if direction.y > 0:
		#animated_sprite.play("look_down")
		#interact_area2D.position = Vector2(0, 64)
	#elif direction.y < 0:
		#animated_sprite.play("look_up")
		#interact_area2D.position = Vector2(0, -64)
	#elif direction.x > 0:
		#animated_sprite.play("look_right")
		#interact_area2D.position = Vector2(64, 0)
	#elif direction.x < 0:
		#animated_sprite.play("look_left")
		#interact_area2D.position = Vector2(-64, 0)
	move_and_slide()
	
func take_damage(damage: int) -> void:
	if not is_invincible:
		health -= damage
		if health <= 0:
			SignalBus.player_death.emit()
		move_and_slide()
		make_invincible(invincible_time)
		
		# Flash red on hit
		modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		modulate = Color.WHITE
		

func make_invincible (time: float) -> void:
	is_invincible = true
	await get_tree().create_timer(time).timeout
	is_invincible = false

func level_up() -> void:
	nutrient_points = fmod(nutrient_points, nutrient_till_next_level)
	nutrient_till_next_level *= 1.1
	level += 1
	SignalBus.player_levelup.emit()
	
	if(nutrient_points > nutrient_till_next_level):
		level_up()

func gain_nutrient_points(points: float) -> void:
	nutrient_points += points
	if (nutrient_points > nutrient_till_next_level):
		level_up()

func _on_player_death() -> void:
	visible = false

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		take_damage((body as Enemy).contact_damage)
		# if enemy is still touching player after invincibility timeout, deal damage again
		await get_tree().create_timer(invincible_time).timeout
		if ($Hurtbox.get_overlapping_bodies() and $Hurtbox.get_overlapping_bodies()[0] == body):
				_on_hurtbox_body_entered(body)

func _on_hurtbox_area_entered(area: Area2D) -> void:
	 # Handles nutrient absorbing
	if area is Nutrient:
		var nutrient = area as Nutrient
		gain_nutrient_points(nutrient.nutrient_point)
		nutrient.queue_free()
	elif area is Mystealium:
		SignalBus.mystealium_pickup.emit()
		area.queue_free()
