extends Area2D
class_name FinishGoal

var level2 = load("res://Levels/level2.tscn")
var is_enabled = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if is_enabled:
			get_tree().change_scene_to_packed(level2)
