extends Area2D

const SPEED = 110

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.is_in_group("enemy"):
		body.die()
	var sfx: AudioStreamPlayer2D = RelativeSFX.new()
	sfx.stream = load("res://Assets/SFX/explosion.wav")
	sfx.global_position = global_position
	get_tree().root.add_child(sfx)
	sfx.play()
	queue_free()
