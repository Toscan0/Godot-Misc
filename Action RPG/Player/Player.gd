extends KinematicBody2D

export var acceleration = 10
export var friction = 10
export var max_speed = 100

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var vel = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Iddle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		vel = vel.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animationState.travel("Iddle")
		vel = vel.move_toward(Vector2.ZERO, friction * delta)
		
	vel = move_and_slide(vel)
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
func attack_state(delta):
	vel = Vector2.ZERO
	animationState.travel("Attack")
	
func attack_anim_ended():
	state = MOVE
