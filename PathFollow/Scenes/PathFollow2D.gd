extends PathFollow2D

export var runSpeed = 30

var pathLength = 10
var canMove = false

func _process(delta):
	if canMove:
		var i = float(5)/float(pathLength)
		set_unit_offset(i)
		print(i)
	#set_offset(get_offset() + runSpeed * delta)
	
	#if(loop == false and get_unit_offset() == 1):
		#queue_free()

func _on_Dado_dice_used(value):
		print(value)
		canMove = true

func move(value):
	pass
