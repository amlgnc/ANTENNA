extends Node2D

const start_path = preload("res://src/worlds/scenes/StartMenu.tscn")
const options_path = preload("res://src/worlds/scenes/OptionsMenu.tscn")

onready var is_menu = $CurrentScene
onready var menu = $CurrentScene/Menu

var is_start = false
var is_options = false

func _process(_delta):
	# main menu gestion
	if is_menu.get_node("Menu") != null:
		if menu.start == true:
			menu.start = false
			is_start = true
			$MenuTransition.transition()
		elif menu.options == true:
			menu.options = false
			is_options = true
			$MenuTransition.transition()

func _on_MenuTransition_transitioned():
	$CurrentScene.get_child(0).queue_free()
	if is_start:
		$CurrentScene.add_child(start_path.instance())
	elif is_options:
		$CurrentScene.add_child(options_path.instance())
