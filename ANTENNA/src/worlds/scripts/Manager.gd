extends Node2D

onready var path = null
onready var menu = $CurrentScene/Menu

func _process(_delta):
	# main menu gestion
	if $CurrentScene.get_node_or_null("Menu") != null:
		if menu.start == true:
			menu.start = false
			path = preload("res://src/worlds/scenes/Cinematic.tscn")
			$MenuTransition.transition()

func _on_MenuTransition_transitioned():
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(path.instance())
