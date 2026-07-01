extends Sprite2D
class_name Hazards

@onready var danger_area: Area2D = $DangerArea

#Connecting the Signals
func _ready() -> void:
	danger_area.body_entered.connect(blob_entered)

#Hurting the Blob
func blob_entered(body: Node2D):
	if body is CharacterBody2D:
		body.hurt_blob()
