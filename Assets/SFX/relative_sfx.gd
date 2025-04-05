extends AudioStreamPlayer2D
class_name RelativeSFX

func _ready() -> void:
	bus = "SFX"
	connect("finished", delete_sfx)

func delete_sfx():
	queue_free()
