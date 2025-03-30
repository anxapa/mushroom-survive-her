extends Enemy
var can_charge = false

func _ready() -> void:
	super()
	contact_damage = 1
	print(global_position)

func _physics_process(delta: float) -> void:
	super(delta)
		
