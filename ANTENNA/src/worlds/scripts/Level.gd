extends Node2D

const final = preload("res://src/worlds/scenes/Final.tscn")

var timer_on = false

func _process(_delta):
	# the level begins
	if $LevelTransition.cmpt == 0:
		$LevelTransition.anim_ready()
	# fight text
	if $LevelTransition.cmpt == 1:
		timer_on = true
		$LevelTransition/IndicationSFX.play()
		$LevelTransition.anim_fight()
		$Player.turn = true
		$Boss.turn = true
	# fade management
	if $LevelTransition.fade == false and $LevelTransition.cmpt == 1:
		$LevelTransition.transition()
	
	# stats
	$LevelStats/PVContainer/HP_current.text = String($Player.stats_hp)
	$LevelStats/PPContainer/PP_current.text = String($Player.stats_pp)
	
	# victory
	if $Boss.hp <= 0:
		get_tree().change_scene_to(final)
