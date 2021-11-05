extends Spatial

var start = false

func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer2/Start.grab_focus()

func _on_Start_pressed():
	start = true

func _on_Quit_pressed():
	get_tree().quit()
