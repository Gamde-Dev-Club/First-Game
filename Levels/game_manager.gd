extends Node
class_name GameManager

var main_menu = load("res://UI/main_menu.tscn")
@onready var escape: Button = $UI/Escape

@onready var score: Label = $UI/Score
@onready var camera_2d: Camera2D = $Camera2D
@onready var player: Player = $Player
@onready var enemies: Node = $Enemies
@onready var finish_goal: FinishGoal = $FinishGoal

var enemies_alive: int

func _ready() -> void:
	escape.connect("pressed", exit_to_menu)
	enemies_alive = enemies.get_child_count()
	for enemy in enemies.get_children():
		enemy.connect("has_died",enemy_killed)

func enemy_killed():
	enemies_alive -= 1

func exit_to_menu():
	get_tree().change_scene_to_packed(main_menu)

func _process(delta: float) -> void:
	if enemies_alive <= 0:
		finish_goal.is_enabled = true
	else:
		finish_goal.is_enabled = false
	if player:
		camera_2d.global_position = player.global_position
