extends CharacterBody2D

@export var speed = 100
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var label: Label
@onready var gun_point: Marker2D = $GunPoint

const FIREBALL: PackedScene = preload("res://fireball.tscn")
var mouse_position
var score = 0

func _physics_process(delta: float):
	mouse_position = get_global_mouse_position()
	gun_point.look_at(mouse_position)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var fireball: Node2D = FIREBALL.instantiate()
		fireball.global_transform = gun_point.global_transform
		get_tree().root.add_child(fireball)
	
	var input_dir: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_dir * speed
	if velocity:
		sprite.play("walk")
	else:
		sprite.play("idle")
	
	move_and_slide()

func add_score():
	score += 1
	label.text = "Score = "+str(score)
	scale.x += 1
