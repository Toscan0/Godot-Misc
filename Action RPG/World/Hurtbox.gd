extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

export(bool) var show_hit = true
var invincible = false setget set_invincible

signal invicibility_started
signal invicibility_ended

onready var timer = $Timer

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invicibility_started")
	else:
		emit_signal("invicibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func create_hit_effect():
	var effect  = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_Timer_timeout():
	self.invincible = false

func _on_Hurtbox_invicibility_started():
	set_deferred("monitorable", false)

func _on_Hurtbox_invicibility_ended():
	monitorable = true
