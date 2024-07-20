extends Node2D

@onready var title = $Title
@onready var subtitle = $Subtitle
@onready var first_timer = $Camera/FirstTimer
@onready var camera = $Camera
@onready var heaven_man = $HeavenMan
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

var start = 1
var tune_1_play = false
var tune_2_play = false

func _physics_process(delta):
	if tune_1_play == true and hell_tune_1.playing == false and tune_2_play == false:
		hell_tune_2.play()
		tune_2_play = true
	if Input.is_action_just_pressed("Enter"):
		start = 2
		first_timer.start()
		heaven_tune.play()
		tune_timer.start()
		title.text = '''To Hell

(Ft. Heaven)'''
		title_song.playing = false
	if start == 2:
		camera.position.y += 2
	if start == 3:
		heaven_man.rotation -= 0.02
	if start ==4:
		camera.position.y += 2
	if start == 5:
		hell_biker.position.x -= 5
		hell_biker_2.position.x -= 4
	if start == 6:
		camera.position.y -= 10

func _on_first_timer_timeout():
	start = 3
	rotation_timer.start()
	slide_whistle.play()

func _on_rotation_timer_timeout():
	start = 4
	second_timer.start()
	bike_timer.start()
	bike_timer_2.start()

func _on_second_timer_timeout():
	start = 5
	friend.visible = true
	heaven_npc.visible = false
	heaven_man.rotation = 0
	#heaven_man.flip_h = true
	wait_timer.start()

func _on_wait_timer_timeout():
	start = 6
	third_timer.start()

func _on_third_timer_timeout():
	start = 7

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
