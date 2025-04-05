extends Control

@onready var audio_settings: CanvasLayer = $AudioSettings
@onready var level_selector: CanvasLayer = $LevelSelector
@onready var main_menu: CanvasLayer = $MainMenu

@onready var audio_to_home: Button = $AudioSettings/AudioToHome
@onready var level_selector_to_home: Button = $LevelSelector/LevelSelectorToHome
@onready var home_to_audio: Button = $MainMenu/HBoxContainer/VBoxContainer/HomeToAudio
@onready var home_to_level_selector: Button = $MainMenu/HBoxContainer/VBoxContainer/HomeToLevelSelector



@onready var slider_master: HSlider = $AudioSettings/VBoxContainer/SliderMaster
@onready var slider_music: HSlider = $AudioSettings/VBoxContainer/SliderMusic
@onready var slider_sfx: HSlider = $AudioSettings/VBoxContainer/SliderSFX

var level1 = load("res://Levels/level1.tscn")
var level2 = load("res://Levels/level2.tscn")

func _ready():
	main_menu.visible = true
	audio_settings.visible = false
	level_selector.visible = false
	
	audio_to_home.connect("pressed", navigate_to_home)
	level_selector_to_home.connect("pressed", navigate_to_home)
	home_to_audio.connect("pressed", navigate_to_audio_settings)
	home_to_level_selector.connect("pressed", navigate_to_level_selector)
	
	# Connect slider changes to volume change methods
	slider_master.value_changed.connect(_on_slider_master_value_changed)
	slider_music.value_changed.connect(_on_slider_music_value_changed)
	slider_sfx.value_changed.connect(_on_slider_sfx_value_changed)
	
	# Initialize sliders (optional - use saved values if available)
	slider_master.value = db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	slider_music.value = db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	slider_sfx.value = db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

# Converts from slider (0 to 1) to decibels
func slider_to_db(value: float) -> float:
	return lerp(-60.0, 0.0, value)  # -60 dB is essentially mute

# Converts from decibels to slider value (0 to 1)
func db_to_slider(db: float) -> float:
	return inverse_lerp(-60.0, 0.0, db)

func _on_slider_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), slider_to_db(value))

func _on_slider_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), slider_to_db(value))

func _on_slider_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), slider_to_db(value))


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_packed(level1)


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_packed(level2)

func navigate_to_home() -> void:
	main_menu.visible = true
	audio_settings.visible = false
	level_selector.visible = false

func navigate_to_level_selector():
	level_selector.visible = true
	main_menu.visible = false
	audio_settings.visible = false

func navigate_to_audio_settings():
	audio_settings.visible = true
	level_selector.visible = false
	main_menu.visible = false
