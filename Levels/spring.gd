extends AnimatedSprite2D

@export var spring_force: int = 24
@export var spring_time: float = 0.5

func spring(body: Node2D):
	if body is CharacterBody2D:
		body.wait_time = spring_time
		if rotation_degrees == 0:
			print("Go UP")
			body.velocity = Vector2(0, -spring_force)
		elif rotation_degrees == 180:
			print("Go DOWN")
			body.velocity = Vector2(0, spring_force)
		elif rotation_degrees == 90:
			print("Go RIGHT")
			body.velocity = Vector2(spring_force, 0)
		elif rotation_degrees == -90:
			print("Go LEFT")
			body.velocity = Vector2(-spring_force, 0)
		play("SpringBounce")
