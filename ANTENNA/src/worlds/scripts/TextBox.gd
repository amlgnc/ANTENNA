extends CanvasLayer

const CHAR_READ_RATE = 0.05

onready var textbox_container = $TextboxContainer
onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label
onready var timer = get_node("Timer")

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []
var state = 0
var timer_end = false

func _ready():
	timer.set_wait_time(1.5)
	timer.start()
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
	match current_state:
		State.READY:
			if !(text_queue.empty()) and timer_end:
				state += 1
				$DialogueSFX.play()
				# boss effects
				if state == 11 or state == 12 or state == 15 or state > 17:
					$IntroBoss.play()
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
		$IntroTransition/AnimationPlayer.play("fade")

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

func _on_Tween_tween_completed(object, key):
	end_symbol.text = ">"
	change_state(State.FINISHED)

func _on_Timer_timeout():
	timer_end = true

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://src/worlds/scenes/Level.tscn")
