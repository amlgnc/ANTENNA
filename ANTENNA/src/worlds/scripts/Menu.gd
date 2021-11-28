extends Node2D

var pressed = false
var start = false

func _ready():
	$Menu/VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
	if pressed == false:
		pressed = true
		$SelectSFX.play()
		start = true

func _on_Quit_pressed():
	if pressed == false:
		get_tree().quit()


func _on_Start_focus_entered():
	$MovementSFX.play()


func _on_Quit_focus_entered():
	$MovementSFX.play()
