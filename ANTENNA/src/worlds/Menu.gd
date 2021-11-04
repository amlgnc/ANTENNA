extends MarginContainer

func _ready():
	$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer2/Start.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene("res://src/worlds/test.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://src/worlds/test.tscn")

func _on_Quit_pressed():
	get_tree().quit()
