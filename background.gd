extends Node2D

@onready var player = $Player
@onready var cam = $Camera2D

var struck = null

func _ready():
	var s = get_viewport_rect().size
	cam.limit_left = 0
	cam.limit_top = 0
	cam.limit_right = int(s.x)
	cam.limit_bottom = int(s.y)
	player.hit.connect(on_hit)
	setup()

func setup():
	var s = get_viewport_rect().size
	player.start(Vector2(s.x * 0.5, s.y - 100))
	for a in get_tree().get_nodes_in_group("asteroid"):
		a.queue_free()

func on_hit():
	var near = null
	var dist = INF
	for a in get_tree().get_nodes_in_group("asteroid"):
		var d = player.position.distance_to(a.position)
		if d < dist:
			dist = d
			near = a
	struck = near
	get_tree().paused = true
	blink(3)

func blink(n):
	if n == 0:
		get_tree().paused = false
		struck = null
		setup()
		return
	player.hide()
	if struck:
		struck.hide()
	await get_tree().create_timer(0.2, true).timeout
	player.show()
	if struck:
		struck.show()
	await get_tree().create_timer(0.2, true).timeout
	blink(n - 1)
