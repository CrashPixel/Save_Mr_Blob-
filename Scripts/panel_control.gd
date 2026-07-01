extends Node2D

@onready var on_off_buttons = $OnOff
@onready var restart_lever = $Restart
@onready var speed_up_lever = $SpeedUp
@onready var restart_screen = $RestartScreen
@onready var mr_blob = get_node("../MrBlob")

@export var doors: Node2D
var button_is_on = true
var sped_up = false
var can_take_inputs = true

func _process(_delta: float) -> void:
	if can_take_inputs:
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
		if Input.is_action_just_pressed("Restart"):
			print("Restarting")
			mr_blob.hit_restart = true
			mr_blob.hurt_blob()
			await get_tree().create_timer(3.0).timeout
			restart_screen.visible = true
		can_take_inputs = mr_blob.can_move
