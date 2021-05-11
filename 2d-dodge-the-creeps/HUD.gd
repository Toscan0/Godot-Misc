extends CanvasLayer

signal start_game


func update_score(score):
	$ScoreLabel.text = str(score)
	
func show_message(text):
	$MSGLabel.text = text
	$MSGLabel.show()
	$msgTimer.start()

func _on_Button_pressed():
	$Button.hide()
	emit_signal("start_game")


func _on_msgTimer_timeout():
	$MSGLabel.hide()
	
	
func show_game_over():
	show_message("Game Over")
	yield($msgTimer, "timeout")
	$MSGLabel.text = "Dodge the Creeps"
	$MSGLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Button.show()
	
	
