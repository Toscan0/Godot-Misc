extends KinematicBody2D

export var acceleration = 10
export var friction = 10
export var max_speed = 100
export var roll_speed = 125

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var vel = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtBox = $Hurtbox

func _ready():
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = roll_vector
		animationTree.set("parameters/Iddle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		vel = vel.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animationState.travel("Iddle")
		vel = vel.move_toward(Vector2.ZERO, friction * delta)
		
	move()
	
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func roll_state(deta):
	vel = roll_vector * roll_speed
	animationState.travel("Roll")
	move()
		
func attack_state(delta):
	vel = Vector2.ZERO
	animationState.travel("Attack")
	
func attack_anim_ended():
	state = MOVE
	
func roll_anim_ended():
	state = MOVE

func move():
	vel = move_and_slide(vel)

func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	hurtBox.start_invincibility(0.5)
	hurtBox.create_hit_effect()
