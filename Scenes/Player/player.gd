extends CharacterBody2D
class_name Player

@onready var main: Window = get_tree().root
signal player_died

@export var score_display: Label
var score = 0

@export var speed = 90
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const FIREBALL: PackedScene = preload("res://Scenes/Fireball/fireball.tscn")
@onready var gun_point: Marker2D = $GunPoint
@onready var shoot_timer: Timer = $ShootTimer
@export var time_between_shots: float = 0.5

func _ready() -> void:
	shoot_timer.wait_time = time_between_shots
	shoot_timer.one_shot = true

func _physics_process(delta: float):
	var mouse_position = get_global_mouse_position()
	gun_point.look_at(mouse_position)
	if Input.is_action_just_pressed("shoot") and shoot_timer.is_stopped():
		var fireball: Node2D = FIREBALL.instantiate()
		fireball.global_transform = gun_point.global_transform
		main.add_child(fireball)
		shoot_timer.start(time_between_shots)
	
	var input_dir: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_dir * speed
	if velocity:
		sprite.play("walk")
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0:
			sprite.flip_h = true
	else:
		sprite.play("idle")
	move_and_slide()

func add_score():
	score += 1
	score_display.text = "Score = "+str(score)

func die():
	emit_signal("player_died")
	queue_free()
