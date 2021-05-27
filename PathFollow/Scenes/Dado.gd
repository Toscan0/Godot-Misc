extends Node2D

signal dice_used(value)

var rng = RandomNumberGenerator.new()
var canLaunchDice = true

onready var diceText = $Label

func _ready():
	diceText.text = "Dice = X"

func _on_Button_pressed():
	if canLaunchDice:
		canLaunchDice = false
		updateDado()

func updateDado():
	rng.randomize()
	var my_random_number = rng.randi_range(1, 6)
	diceText.text = "Dice = " + str(my_random_number)
	emit_signal("dice_used", my_random_number)
