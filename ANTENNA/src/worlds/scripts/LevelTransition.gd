extends CanvasLayer

var fade = false
var cmpt = 0

func transition():
	$AnimationFade.play("fade_to_normal")
	
func anim_ready():
	$TextGame/AnimationIndication.play("indication_ready")
	
func anim_fight():
	$TextGame/AnimationIndication.play("indication_fight")

func _on_AnimationFade_animation_finished(_anim_name):
	fade = true
	cmpt = cmpt + 1

func _on_AnimationIndication_animation_finished(_anim_name):
	cmpt = cmpt + 1
