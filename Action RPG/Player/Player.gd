extends KinematicBody2D

export var sensitivity = 1
export var acceleration = 10
export var friction = 10
export var max_speed = 100

var vel = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		vel += input_vector * acceleration * delta
		vel = vel.clamped(max_speed * delta)
	else:
		vel = vel.move_toward(Vector2.ZERO, friction * delta)
		
	vel = move_and_slide(vel * sensitivity)
