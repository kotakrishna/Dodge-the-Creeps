extends Node

export(PackedScene) var mob_scene
var score

var playerLife = 3


func _ready():
	randomize()
	new_game()
	$HUD.update_score(0)

func game_over():
	
	if(playerLife>=1):
		get_tree().call_group("mobs","queue_free")
		$HUD.show_message("Hit")
		$Player.start($StartPosition.position)
		playerLife -= 1
		$HUD.update_player_life(playerLife)
	else:
		$ScoreTimer.stop()
		$MobTimer.stop()
		$HUD.show_game_over()
		get_tree().call_group("mobs","queue_free")
		$Player.kill_player()
	pass # Replace with function body.

func new_game():
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
	$HUD.update_score(score)
	pass # Replace with function body.


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass # Replace with function body.


func _on_HUD_start_game():
	new_game()
	pass # Replace with function body.
