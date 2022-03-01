extends Node

export(PackedScene) var mob_scene
export(PackedScene) var power_scene
var score
signal life_changed(player_hearts)

var playerLife = 3
var MAX_HEARTS:int = 3
var hearts = MAX_HEARTS

func _ready():
	randomize()
	connect("life_changed",get_parent().get_node("UI/Life"),"on_player_life_changed");
	$HUD.update_power_level(0)
	$HUD.update_score(0)


func _physics_process(delta):
	#print(delta,"count")
	$HUD.update_power_level($Player.powerCounter);
func game_over():
	hearts -= 1
	emit_signal("life_changed",hearts);
	if(playerLife>=2):
		$Music.play()
		get_tree().call_group("mobs","queue_free")
		$HUD.show_message("Hit")
		$Player.start($StartPosition.position)
		playerLife -= 1
		emit_signal("life_changed",hearts)
		$HUD.update_player_life(str(playerLife))
	else:
		$ScoreTimer.stop()
		$MobTimer.stop()
		$HUD.show_game_over()
		get_tree().call_group("mobs","queue_free")
		$Player.kill_player()
		$DeathSound.play()
		$Music.stop()
	pass # Replace with function body.

func new_game():
	hearts = MAX_HEARTS
	emit_signal("life_changed",MAX_HEARTS)
	$Music.play()
	score = 0
	playerLife = 3
	$HUD.update_score("0")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs","queue_free")

func _on_MobTimer_timeout():
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation");
	mob_spawn_location.offset = randi();
	
	
	var mob = mob_scene.instance();
	add_child(mob);
	
	
	var direction = mob_spawn_location.rotation + PI/2
	
	mob.position = mob_spawn_location.position
	
	direction += rand_range(-PI/4,PI/4);
	mob.rotation = direction;
	
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score);
	if(score%10):
		randomize()
		$Background.updateColor(Color(randf(),randf(),randf(),1.0));
	pass # Replace with function body.


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$PowerTimer.start()
	pass # Replace with function body.


func _on_HUD_start_game():
	new_game()
	pass # Replace with function body.


func _on_PowerTimer_timeout():
	
	var power_spawn_location = get_node("PowerPath/PowerSpawnLocation");
	power_spawn_location.offset = randi();
	
	
	var power = power_scene.instance();
	add_child(power);
	var direction = power_spawn_location.rotation + PI/2
	
	power.position = power_spawn_location.position
	
	direction += rand_range(-PI/4,PI/4);
	power.rotation = direction;
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	power.linear_velocity = velocity.rotated(direction)
	pass # Replace with function body.
