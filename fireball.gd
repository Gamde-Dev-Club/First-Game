extends Area2D

const SPEED = 30

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta
