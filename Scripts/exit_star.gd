extends Sprite2D

@onready var audio: AudioStreamPlayer2D = get_node("/root/Level/Audio")
@onready var win_graphic: Node2D = $Win
@export var levels: Array = []
@export var pick_level: int
const WAIT_TIME = 2.0

func win(body: Node2D):
	if body is CharacterBody2D:
		body.can_move = false
		win_graphic.visible = true
		audio.switch_audio()
		await get_tree().create_timer(WAIT_TIME).timeout
		get_tree().change_scene_to_file(levels[pick_level])
