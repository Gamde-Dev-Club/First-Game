extends Control


var level1 = load("res://Levels/level1.tscn")
var level2 = load("res://Levels/level2.tscn")


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_packed(level1)


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_packed(level2)
