extends CharacterBody2D
@export var speed = 900;
var health := 3

func _ready() -> void:
	GameManager.set_player(self)

func _physics_process(delta: float) -> void:
	movement(delta)
	print(health)

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
	health -= damage

func _on_hurtbox_body_entered(body: Node2D) -> void:
	take_damage((body as Enemy).contact_damage)
	
	
