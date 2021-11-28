extends KinematicBody2D

const TARGET_FPS = 60
const ACCELERATION = 15
const MAX_SPEED = 350
const GRAVITY = 50
const JUMP_FORCE = 1000
const bullet_path = preload("res://src/worlds/scenes/Laser.tscn")

var motion = Vector2.ZERO

var stats_hp = 30
var stats_pp = 30

var turn = false

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

func _process(_delta):
	if stats_hp <= 0:
		get_tree().reload_current_scene()

func _physics_process(delta):
	motion.y += GRAVITY * delta * TARGET_FPS
	
	if turn == true:
		if is_on_floor():
			animationPlayer.play("Stand")
			if Input.is_action_just_pressed("ui_up"):
				$JumpSFX.play()
				motion.y = -JUMP_FORCE
		else:
			animationPlayer.play("Jump")
			if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
				motion.y = -JUMP_FORCE/2
		if Input.is_action_just_pressed("ui_accept") and stats_pp >= 5:
			stats_pp = stats_pp - 5
			$LaserSFX.play()
			shoot()
	
	motion = move_and_slide(motion, Vector2.UP)
	
func shoot():
	var bullet = bullet_path.instance()
	get_parent().add_child(bullet)
	bullet.position = $antenna.global_position


func _on_Area2D_area_entered(area):
	pass
