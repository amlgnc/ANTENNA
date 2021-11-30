extends CanvasLayer

var time = 0

func _process(delta):
	if get_parent().timer_on == true:
		time += delta
	
	var mils = fmod(time,1)*1000
	var secs = fmod(time,60)
	var mins = fmod(time, 60*60) / 60
	
	var time_passed = "%02d:%02d:%02d" % [mins,secs,mils]
	Globals.time_speedrun = time_passed
	$Chrono/Chronometer.text = time_passed
