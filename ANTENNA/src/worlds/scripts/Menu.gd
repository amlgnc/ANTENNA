extends Node2D

var start = false

func _ready():
	$Menu/VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
	start = true

func _on_Quit_pressed():
	get_tree().quit()
