extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

var newColor : Color
func _ready():
	randomize()
	modulate = Color(randf(),randf(),randf(),0.1)
	pass # Replace with function body.


func _process(delta):
	pass;
func updateColor(value):
	modulate = lerp(modulate,newColor,0.1);
	newColor = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
