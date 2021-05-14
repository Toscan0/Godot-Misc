extends KinematicBody2D

export var sensitivity = 4
var vel = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * sensitivity
	input_vector.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * sensitivity
	
	if input_vector != Vector2.ZERO:
		vel = input_vector
	else:
		vel = Vector2.ZERO
		
	move_and_collide(vel)
