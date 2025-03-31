extends Label

var time := 600.0

func _process(delta: float) -> void:
	var int_time := time as int
	text = "%02d:%02d" % [int_time / 60, int_time % 60]
	time -= delta
