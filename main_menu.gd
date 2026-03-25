extends Node2D

const GITHUB_URL = "https://github.com/basic-bitch-foundation/space_shooter"

func _ready() -> void:
	$play.pressed.connect(on_play)
	$github.pressed.connect(on_github)

func on_play() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func on_github() -> void:
	OS.shell_open(GITHUB_URL)
