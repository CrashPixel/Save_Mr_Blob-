extends Node2D

@onready var audio: AudioStreamPlayer2D = get_node("/root/Level/Audio")
@onready var mr_blob: CharacterBody2D = get_node("../MrBlob")
@onready var doors: Node2D = get_node("../Doors")
@onready var on_off_buttons = $OnOff
@onready var restart_lever = $Restart
@onready var speed_up_lever = $SpeedUp
@onready var restart_screen = $RestartScreen
@onready var death_screen = $DeathScreen
@onready var ui_animations = $UIAnimations

const WAIT_TIME: float = 2.0
var button_is_on: bool = true
var sped_up: bool = false
var can_take_inputs: bool = true

func taking_inputs():
	#Turning off Inputs at the same time Mr Blob stops being allowed to move
	can_take_inputs = mr_blob.can_move
	if can_take_inputs:
		#Handling the turning On/Off of the doors
		if Input.is_action_just_pressed("OnOffToggle"):
			if button_is_on:
				print("Turn OFF")
				for child in doors.get_children():
					child.get_node("StaticBody2D/CollisionShape2D").set_disabled(true)
					child.visible = false
				button_is_on = false
				on_off_buttons.set_region_rect(Rect2(57, 3, 30, 10))
			elif !button_is_on:
				print("Turn ON")
				for child in doors.get_children():
					child.get_node("StaticBody2D/CollisionShape2D").set_disabled(false)
					child.visible = true
				button_is_on = true
				on_off_buttons.set_region_rect(Rect2(9, 3, 30, 10))
			print("Toggle")
		
		#Handling the Speeding Up of Mr Blob
		if Input.is_action_just_pressed("SpeedUp"):
			if !sped_up:
				mr_blob.blob_speed *= 2
				sped_up = true
				speed_up_lever.set_region_rect(Rect2(89, 3, 6, 10))
				print("SPEED IS KEY")
			elif sped_up:
				mr_blob.blob_speed /= 2
				sped_up = false
				speed_up_lever.set_region_rect(Rect2(41, 3, 6, 10))
				print("speed is NOT key")
		
		#Simply signalling a Restart
		if Input.is_action_just_pressed("Restart"):
			print("Restarting")
			restart_lever.set_region_rect(Rect2(49, 3, 6, 10))
			mr_blob.hit_restart = true
			hurt_blob()

func restarting_the_level():
	#Temp Restarting. Will improve later when I bring in the screen Animations
	if restart_screen.visible:
		if Input.is_action_just_pressed("Select"):
			ui_animations.play("RestartScreen")
			await get_tree().create_timer(WAIT_TIME).timeout
			get_tree().reload_current_scene()
	if death_screen.visible:
		if Input.is_action_just_pressed("Select"):
			ui_animations.play("DeathScreen")
			await get_tree().create_timer(WAIT_TIME).timeout
			get_tree().reload_current_scene()

func hurt_blob():
	#Ennacting the lose scenario
	mr_blob.can_move = false
	mr_blob.set_velocity(Vector2(0,0))
	audio.switch_audio()
	#Determining what Screen to display
	if mr_blob.hit_restart:
		mr_blob.animations.play("blob_stuck")
		await get_tree().create_timer(WAIT_TIME).timeout
		restart_screen.visible = true
		audio.switch_audio()
	else:
		mr_blob.animations.play("blob_hurt")
		await get_tree().create_timer(WAIT_TIME).timeout
		death_screen.visible = true
		audio.switch_audio()

func _process(_delta: float) -> void:
	taking_inputs()
	restarting_the_level()
	
