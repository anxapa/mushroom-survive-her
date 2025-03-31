extends Enemy

# this is the worst code i've written in my entire life 

var can_charge := true
var chargeup_time := 0.5
var charge_time := 5
var charging := false
var charge_end
var charge_speed = 1000
var target = player.global_position
# values less than 1 stop the charge short
var offset = 3

func _ready() -> void:
	super()
	contact_damage = 2

func _physics_process(delta: float) -> void:
	# in charge range
	if ((player.global_position - global_position).length() < 400 and can_charge):
		charge()
	# not charging
	elif not charging:
		super(delta)
	#currently charging
	else:
		global_position = global_position.move_toward(target, charge_speed * delta)
		charge_speed -= charge_speed/5.0 * charge_time * delta
		if global_position == target or charge_speed < base_speed:
			(charge_end as SceneTreeTimer).set_time_left(0)

func charge() -> void:
	can_charge = false
	speed = 50
	target = global_position + (player.global_position - global_position)*offset
	await get_tree().create_timer(chargeup_time).timeout
	charging = true
	$CollisionShape2D.disabled = true
	charge_end = get_tree().create_timer(charge_time + randf_range(0.1, 0.4))
	await charge_end.timeout
	charge_speed = 1000
	can_charge = true
	charging = false
	$CollisionShape2D.disabled = false
	speed = base_speed
	
# TODO: Variants
