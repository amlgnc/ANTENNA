extends StaticBody2D

const bullet_red_path = preload("res://src/worlds/scenes/Bullet_red.tscn")
const bullet_blue_path = preload("res://src/worlds/scenes/Bullet_blue.tscn")

var turn = false
var hp = 40

onready var timer = get_node("Timer")

func _ready():
	timer.set_wait_time(0.40)
	timer.start()
			
func _on_Timer_timeout():
	var random = randi()%10+1
	if turn == true:
		if random < 8:
			shoot_red()
			pass
		else:
			pass
			shoot_blue()
	timer.set_wait_time(0.40)
	timer.start()
	
func shoot_red():
	var zone = randi()%10+1
	var bullet = bullet_red_path.instance()
	get_parent().add_child(bullet)
	if zone < 7:
		bullet.position = $arm.global_position
	else:
		bullet.position = $head.global_position
	
func shoot_blue():
	var zone = randi()%10+1
	var bullet = bullet_blue_path.instance()
	get_parent().add_child(bullet)
	if zone < 7:
		bullet.position = $arm.global_position
	else:
		bullet.position = $head.global_position


func _on_Area2D_area_entered(area):
	$BossHurtSFX.play()
	hp = hp - 1
