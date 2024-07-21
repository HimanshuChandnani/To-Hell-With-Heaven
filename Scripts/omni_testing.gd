extends Node2D

@onready var title = $Title
@onready var subtitle = $Subtitle
@onready var first_timer = $Camera/FirstTimer
@onready var camera = $Camera
@onready var rotation_timer = $Camera/RotationTimer
@onready var second_timer = $Camera/SecondTimer
@onready var friend = $Friend
@onready var heaven_npc = $HeavenNpc
@onready var hell_biker = $HellBiker
@onready var wait_timer = $Camera/WaitTimer
@onready var third_timer = $Camera/ThirdTimer
@onready var bike_timer = $Camera/BikeTimer
@onready var title_song = $Camera/TitleSong
@onready var bike_timer_2 = $Camera/BikeTimer2
@onready var hell_biker_2 = $HellBiker2
@onready var test_timer = $Camera/TestTimer
@onready var heaven_tune = $Camera/HeavenTune
@onready var slide_whistle = $Camera/SlideWhistle
@onready var tune_timer = $Camera/TuneTimer
@onready var bike = $HellBiker/Bike2
@onready var bike_2 = $HellBiker2/Bike3
@onready var hell_tune_1 = $Camera/HellTune1
@onready var hell_tune_2 = $Camera/HellTune2
@onready var sight_line_1 = $HeavenNpc/SightLine1
@onready var sight_line_2 = $HeavenNpc/SightLine2
@onready var sight_line_3 = $HeavenNpc/SightLine3
@onready var sight_timer = $HeavenNpc/SightTimer
@onready var yell_timer = $Friend/YellTimer
@onready var ellipsis_1 = $Friend/Ellipsis1
@onready var ellipsis_2 = $Friend/Ellipsis2
@onready var ellipsis_3 = $Friend/Ellipsis3
@onready var a_1 = $Friend/A1
@onready var a_2 = $Friend/A2
@onready var a_3 = $Friend/A3
@onready var h = $Friend/H
@onready var exclaimation = $"Friend/Exclaimation"
@onready var heaven_s_golden_gate = $"Heaven's Golden Gate"
@onready var gate_timer = $"Heaven's Golden Gate/GateTimer"
@onready var heaven_man = $Rykting
@onready var startarea = $Startarea
@onready var killzone = $Killzone
@onready var second_half_timer = $Camera/SecondHalfTimer

var start = 1
var tune_1_play = false
var tune_2_play = false
var enter = false
var sights = 1
var yells = 2
var x = 2

func _ready():
	$Rykting/Player.on = 0
	killzone.fly = false

func _physics_process(delta):
	if killzone.fly == true:
		$Rykting/Player/Halo.visible = true
		if startarea.start_pos != $Rykting/Player.global_position:
			if $Rykting/Player.global_position.x < startarea.start_pos.x+2:
				$Rykting/Player.global_position.x += 10
			if $Rykting/Player.global_position.x > startarea.start_pos.x-2:
				$Rykting/Player.global_position.x -= 10
			if $Rykting/Player.global_position.y < startarea.start_pos.y+2:
				$Rykting/Player.global_position.y += 10
			if $Rykting/Player.global_position.y > startarea.start_pos.y-2:
				$Rykting/Player.global_position.y -= 10
		else:
			killzone.fly = false
			$Rykting/Player/Halo.visible = false
	
	if tune_1_play == true and hell_tune_1.playing == false and tune_2_play == false:
		hell_tune_2.play()
		tune_2_play = true
	if Input.is_action_just_pressed("Enter") and enter == false:
		enter = true
		start = 2
		first_timer.start()
		heaven_tune.play()
		tune_timer.start()
		title.text = '''To Hell

(Ft. Heaven)'''
		title_song.playing = false
	match start:
		2:
			camera.position.y += 2
		3:
			heaven_man.rotation -= 0.02
		4:
			camera.position.y += x
		5:
			hell_biker.position.x -= 5
			hell_biker_2.position.x -= 4
		6:
			camera.position.y -= 10
		8:
			heaven_s_golden_gate.skew += 0.2
	if start == 9:
		if camera.global_position.x < $Rykting/Player.global_position.x+10:
			camera.global_position.x += 10
		if camera.global_position.x > $Rykting/Player.global_position.x-10:
			camera.global_position.x -= 10
		if camera.global_position.y < $Rykting/Player.global_position.y+10:
			camera.global_position.y += 10
		if camera.global_position.y > $Rykting/Player.global_position.y-10:
			camera.global_position.y -= 10

func _on_first_timer_timeout():
	start = 3
	rotation_timer.start()
	slide_whistle.play()

func _on_rotation_timer_timeout():
	start = 4
	second_timer.start()
	bike_timer.start()
	bike_timer_2.start()
	sight_timer.start()

func _on_second_timer_timeout():
	x = 5
	second_half_timer.start()

func _on_wait_timer_timeout():
	start = 6
	third_timer.start()

func _on_third_timer_timeout():
	start = 7
	yell_timer.start()

func _on_bike_timer_timeout():
	bike.play()

func _on_bike_timer_2_timeout():
	bike_2.play()

func _on_timer_timeout():
	if subtitle.visible == true:
		subtitle.visible = false
	elif subtitle.visible == false and start == 1:
		subtitle.visible = true

func _on_tune_timer_timeout():
	hell_tune_1.play()
	tune_1_play = true

func _on_sight_timer_timeout():
	match sights:
		1:
			sight_line_1.visible = true
		2:
			sight_line_2.visible = true
		3:
			sight_line_3.visible = true
		4:
			sight_timer.stop()
	sights += 1

func _on_yell_timer_timeout():
	match yells:
		1:
			ellipsis_1.visible = true
		2:
			ellipsis_2.visible = true
		3:
			ellipsis_3.visible = true
		4:
			a_1.visible = true
		5:
			a_2.visible = true
		6:
			a_3.visible = true
		7:
			h.visible = true
		8:
			exclaimation.visible = true
			start = 8
			gate_timer.start()
		9:
			yell_timer.stop()
	yells += 1

func _on_gate_timer_timeout():
	start = 9
	$Rykting/Player.on = 1
	$Rykting/Player.velocity.x = 500

func _on_startarea_body_entered(body):
	if body.has_method("player"):
		killzone.fly = false
		$Rykting/Player/Halo.visible = false

func _on_second_half_timer_timeout():
	start = 5
	friend.visible = true
	heaven_npc.visible = false
	heaven_man.rotation = 0
	#heaven_man.flip_h = true
	wait_timer.start()


func _on_area_2d_body_entered(body):
	if body.has_method('dark'):
		body.dark()
