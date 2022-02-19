extends Area2D

signal hit;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400;

var screen_size;


# Called when the node enters the scene tree for the first time.
func _ready():
	hide();
	screen_size = get_viewport_rect().size;
	pass # Replace with function body.

func _physics_process(delta):
	#get_user_input(delta);
	var velocity = Vector2.ZERO;
	if(Input.is_action_pressed("ui_up")):
		velocity.y -= 1
	if(Input.is_action_pressed("ui_down")):
		velocity.y += 1
	if(Input.is_action_pressed("ui_right")):
		velocity.x += 1
	if(Input.is_action_pressed("ui_left")):
		velocity.x -= 1
	
	#animation_player_movement();
	
	
	if velocity.length()>0 :
		velocity = velocity.normalized() * speed ;
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop();
		
	if velocity.x != 0:
		$AnimatedSprite.animation = "side"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func kill_player():
	hide() 
	$CollisionShape2D.set_deferred("disabled", true)

func _on_Player_body_entered(body):
	#hide() 
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.	
	#$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.
