extends Node
class_name GameManager

@onready var score: Label = $UI/Score
@onready var camera_2d: Camera2D = $Camera2D
@onready var player: Player = $Player

func _process(delta: float) -> void:
	if player:
		camera_2d.global_position = player.global_position

func _on_player_player_died() -> void:
	pass
