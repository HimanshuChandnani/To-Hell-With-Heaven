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
@onready var bike = $Camera/Bike
@onready var bike_timer = $Camera/BikeTimer
@onready var title_song = $Camera/TitleSong

var start = 1

func _on_timer_timeout():
	if subtitle.visible == true:
		subtitle.visible = false
	elif subtitle.visible == false and start == 1:
		subtitle.visible = true

func _physics_process(delta):
	if Input.is_action_just_pressed("Enter"):
		start = 2
		first_timer.start()
		title.text = '''To Hell

(Ft. Heaven)'''
		title_song.playing = false
	if start == 2:
		camera.position.y += 2
	if start == 3:
		heaven_man.rotation -= 0.01
	if start ==4:
		camera.position.y += 2
	if start == 5:
		hell_biker.position.x -= 5
	if start == 6:
		camera.position.y -= 10

func _on_first_timer_timeout():
	start = 3
	rotation_timer.start()

func _on_rotation_timer_timeout():
	start = 4
	second_timer.start()
	bike_timer.start()

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
