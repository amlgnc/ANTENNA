extends Node2D

onready var path = null

func _process(_delta):
	# main menu management
	if $CurrentScene.get_node_or_null("Menu") != null:
		if $CurrentScene/Menu.start == true:
			$CurrentScene/Menu.start = false
			path = preload("res://src/worlds/scenes/Intro.tscn")
			$MenuTransition.transition()

func _on_MenuTransition_transitioned():
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(path.instance())
