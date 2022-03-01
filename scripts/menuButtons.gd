extends Button

export var reference_path = ""
export (bool) var start_focused = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if(start_focused):
		grab_focus()
	
	
	connect("mouse_entered",self,"_on_Button_mouse_entered")
	connect("pressed",self,"_on_Button_Pressed")
	pass # Replace with function body
	
	
	
func _on_Button_mouse_entered():
	grab_focus()


func _on_Button_Pressed():
	print(reference_path)
	if(reference_path!=""):
		get_tree().change_scene(reference_path)
	else:
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
