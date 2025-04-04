extends CharacterBody2D

@onready var player: Node2D = get_node("/root/Main/Player")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
signal has_died

@export var detection_range: float = 100
@export var speed = 50

func _process(delta):
	if player and global_position.distance_to(player.global_position) < detection_range:
		sprite.play("walk")
		var direction = (player.global_position - global_position).normalized()
		global_position += speed * direction * delta
		if direction < Vector2(0,0):
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		global_position += direction * speed * delta
	else:
		sprite.play("idle")

func die():
	#sprite.play("death")
	emit_signal("has_died")
	queue_free()

func _on_killbox_body_entered(body):
	if body is Player:
		body.die()
