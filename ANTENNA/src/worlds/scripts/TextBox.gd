extends CanvasLayer

const CHAR_READ_RATE = 0.05

onready var textbox_container = $TextboxContainer
onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []
var text_start = false

func _ready():
	print("Starting state: State.READY")
	hide_textbox()
	queue_text("....................")
	queue_text("...Where am I?")
	queue_text("...")
	queue_text("And why do i have such a bad headache?")
	queue_text("...")
	queue_text("I think I remember it now...")
	queue_text("..........")
	queue_text("Shit...")
	queue_text("I think one of my antennas has been cut.")
	queue_text("But by whom?")
	queue_text("...")
	queue_text("!!!")
	queue_text("I feel a presence.")
	queue_text("A very imposing presence.")
	queue_text("And it gets closer to me...")
	queue_text("I'm too weak to run away.")
	queue_text("I have to face it.")
	queue_text("...")
	queue_text("And I won't let go!")
	queue_text("Not like the last time...")
	queue_text(".")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		text_start = true;
	match current_state:
		State.READY:
			if !(text_queue.empty()) and text_start == true:
				$DialogueSFX.play()
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.percent_visible = 1.0
				$Tween.remove_all()
				end_symbol.text = ">"
				$DialogueSFX.stop()
				change_state(State.FINISHED)
		State.FINISHED:
			$DialogueSFX.stop()
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()
	if text_queue.empty():
		get_tree().change_scene("res://src/worlds/scenes/Level.tscn")

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	textbox_container.show()

func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.percent_visible = 0.0
	change_state(State.READING)
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")

func _on_Tween_tween_completed(object, key):
	end_symbol.text = ">"
	change_state(State.FINISHED)
