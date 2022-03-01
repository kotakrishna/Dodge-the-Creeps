extends CanvasLayer

signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$PowerLevel.hide()
	pass # Replace with function body.

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	$PowerLevel.value = 0
	$PowerLevel.show()


func show_game_over():
	show_message("Game Over")	
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$PowerLevel.hide()
	$StartButton.show()


func update_score(score):
	$ScoreDisplay.text = str(score)
	
	
func update_player_life(life):
	#$PlayerLifes.text = str(life);
	print("hit")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_power_level(value):
	$PowerLevel.value = value;


func _on_MessageTimer_timeout():
	$Message.hide()
	pass # Replace with function body.



func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	pass # Replace with function body.


func _on_Settings_pressed():
	$StartButton.hide()
	pass # Replace with function body.
