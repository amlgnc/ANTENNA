extends KinematicBody2D

var velocity = Vector2(1, 0)
var speed = 1000

func _physics_process(delta):
	var collision_info = move_and_slide(velocity.normalized() * speed)

func _on_Area2D_body_entered(body):
	queue_free()
