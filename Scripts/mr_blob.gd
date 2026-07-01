extends CharacterBody2D

@onready var sprite: Sprite2D = $MrBlobSprites
@onready var animations: AnimationPlayer = $BlobAnimations

var blob_speed: float = 5.0
var going_right: bool = true
var direction: int = 1
var can_move: bool = true
var wait_time: float = 0.0
var hit_restart: bool = false

func _physics_process(delta: float) -> void:
	#Only allowing movement when we're not dead/beat the level
	if can_move:
		#Applying Gravity
		if wait_time > 0:
			wait_time -= delta
		
		if not is_on_floor() and wait_time <= 0:
			velocity += get_gravity() * delta
		
		#Handling Automatic Movements
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
		
		#Handling Jump Sprites
		if velocity.y < 0:
			sprite.frame = 1
		elif velocity.y > 0:
			sprite.frame = 2
		else:
			sprite.frame = 0

		move_and_slide()
