extends Enemy

func _ready() -> void:
	super()
	contact_damage = 1

func _physics_process(delta: float) -> void:
	super(delta)
		
func make_tank() -> void:
	super.make_tank()
	$Sprite2D.texture = tank_sprite
	
# TODO: Variants
func make_rogue() -> void:
	super.make_rogue()
	
func make_brute() -> void:
	super.make_brute()
