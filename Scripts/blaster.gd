extends Hazards

@onready var ray_cast = $RayCast2D
@onready var beam = $Beam
@onready var hit_box = $DangerArea/HitBox

func _process(_delta: float) -> void:
	#Drawing our beams length based on what the Raycast hits
	var contact = ray_cast.get_collision_point()
	#print(contact)
	beam.position.x = -ceili(self.position.distance_to(contact) / 2)
	beam.set_region_rect(Rect2(0, 0, (-beam.position.x*2), 4))
	danger_area.position = beam.position
	hit_box.shape.set_size(Vector2(abs(beam.position.x*2), 2))
