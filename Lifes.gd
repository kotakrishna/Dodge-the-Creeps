extends Control

var heart_size: int = 45;

func on_player_life_changed(player_heart:float = 3)->void:
	$Hearts.rect_size.x = player_heart * heart_size;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
