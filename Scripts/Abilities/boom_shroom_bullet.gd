extends Bullet

@export var explosion_range := 100.0
@onready var explosion_area := $"Explosion Area"

func _ready() -> void:
	super()
	change_range(explosion_range)
	
func change_range(range_radius: float) -> void:
	$"Explosion Area/CollisionShape2D".shape.radius = range_radius

func _on_body_entered(body: Node2D) -> void:
	if bullet_owner == "Player" and body is Enemy:
		(body as Enemy).take_damage(damage_amount)
		var bodies : Array[Node2D] = explosion_area.get_overlapping_bodies()
		for _body in bodies:
			if _body is Enemy:
				var enemy = _body as Enemy
				enemy.take_damage(damage_amount * 0.5)
		queue_free()
