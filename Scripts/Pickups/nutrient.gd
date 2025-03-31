extends Pickup
class_name Nutrient

var nutrient_point := 1.0
var is_magnetized := false

func _ready() -> void:
	SignalBus.mystealium_pickup.connect(_on_mystealium_pickup)

func _process(delta: float) -> void:
	if is_near_player || is_magnetized:
		home_to_player(delta)

func _on_mystealium_pickup() -> void:
	is_magnetized = true
