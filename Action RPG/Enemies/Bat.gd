extends KinematicBody2D

const EnemyDeathEfx = preload("res://Effects/EnemyDeathEffect.tscn")

enum{
	IDLE,
	WANDER,
	CHASE
}

export var knockback_strengh = 100
export var friction = 200
export var acceleration = 300
export var max_speed = 50

var knockback = Vector2.ZERO
var vel = Vector2.ZERO
var state = IDLE

onready var stats = $Stats
onready var playerDetection = $PlayerDetectionZone
onready var sprite = $AnimSprite
onready var hurtbox = $Hurtbox

func _ready():
	print(stats.max_health)
	print(stats.health)
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * knockback_strengh
	hurtbox.create_hit_effect()
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			vel = vel.move_toward(Vector2.ZERO, friction * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetection.player
			if player != null:
				var dir = (player.global_position - global_position).normalized()
				vel = vel.move_toward(dir * max_speed, acceleration * delta)
			else:
				state = IDLE
	
	sprite.flip_h = vel.x < 0
	vel = move_and_slide(vel)
		
func seek_player():
	if playerDetection.can_see_player():
		state = CHASE
	
func _on_Stats_no_health():
	queue_free()
	var enemyDeathEfx = EnemyDeathEfx.instance()
	get_parent().add_child(enemyDeathEfx)
	enemyDeathEfx.global_position = global_position
