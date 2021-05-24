extends KinematicBody2D

export var knockback_strengh = 100
export var friction = 200

var knockback = Vector2.ZERO

onready var stats = $Stats

func _ready():
	print(stats.max_health)
	print(stats.health)
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * knockback_strengh

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)

func _on_Stats_no_health():
	queue_free()
