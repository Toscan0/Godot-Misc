extends KinematicBody2D

export var knockback_strengh = 100
export var friction = 200

var knockback = Vector2.ZERO

func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * knockback_strengh


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
