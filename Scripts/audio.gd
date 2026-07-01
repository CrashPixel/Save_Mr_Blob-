extends AudioStreamPlayer2D

@export var exit_star: Node2D
@export var mr_blob: Node2D
@export var ui: Node2D

@onready var hurt_song = load("res://Assets/Audio/MrBlob Hurt Song.wav")
@onready var hurt_sound = load("res://Assets/Audio/MrBlob Dead.wav")
@onready var win_sound = load("res://Assets/Audio/MrBlob Win.wav")

func switch_audio():
	if ui.get_child(4).visible or ui.get_child(5).visible:
		set_stream(hurt_song)
		play()
	elif !mr_blob.can_move and !exit_star.win_graphic.visible:
		set_stream(hurt_sound)
		play()
	else:
		set_stream(win_sound)
		play()
