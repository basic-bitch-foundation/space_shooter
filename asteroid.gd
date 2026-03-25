extends Area2D

var spd = 290.0
var drift = 0.5
var spin = 1.0
var sc = 0.02

var ssize = Vector2.ZERO

var imgs = [
	preload("res://images/asteroid_1.png"),
	preload("res://images/asteroid_2.png"),
	preload("res://images/asteroid_3.png")
]

func _ready():
	ssize = get_viewport_rect().size
	add_to_group("asteroid")
	call_deferred("build")

func build():
	var t = imgs[randi() % imgs.size()]

	var s = Sprite2D.new()
	s.texture = t
	s.scale = Vector2(sc, sc)
	add_child(s)

	var c = CollisionShape2D.new()
	var sh = CircleShape2D.new()
	sh.radius = t.get_width() * sc * 0.45
	c.shape = sh
	add_child(c)

func _process(delta):
	position.y += spd * delta
	position.x += drift * delta
	rotation += spin * delta

	if position.x < -32:
		position.x = ssize.x + 32
	elif position.x > ssize.x + 32:
		position.x = -32

	if position.y > ssize.y + 64:
		queue_free()
