extends CharacterBody2D

@onready var sprite: Sprite2D = $MrBlobSprites

var blob_speed: float = 4.0
var going_right: bool = true
var direction: int = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		if is_on_wall() and going_right:
			print("Go Left")
			direction = -1
			sprite.flip_h = true
			going_right = false
		elif is_on_wall() and !going_right:
			print("Go Right")
			direction = 1
			sprite.flip_h = false
			going_right = true
		velocity.x = direction * blob_speed
	else:
		velocity.x = move_toward(velocity.x, 0, blob_speed)
	
	if velocity.y < 0:
		sprite.frame = 1
	elif velocity.y > 0:
		sprite.frame = 2
	else:
		sprite.frame = 0

	move_and_slide()
