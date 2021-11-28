extends KinematicBody2D

var velocity = Vector2(-1, 0)
var speed = 1000

onready var timer = get_node("Timer")

func _ready():
	timer.set_wait_time(1)
	timer.start()

func _physics_process(delta):
	var collision_info = move_and_slide(velocity.normalized() * speed)

func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	get_parent().get_node("Player").stats_pp += 5
	self.hide()
	$PlayerBonusSFX.play()

func _on_Timer_timeout():
	queue_free()
