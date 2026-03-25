extends Area2D

signal hit

@export var speed = 400

var ssize = Vector2.ZERO

func _ready():
	ssize = get_viewport_rect().size
	hide()
	collision_layer = 1
	collision_mask = 2
	monitoring = true
	monitorable = true
	area_entered.connect(touched)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	if dir.length() > 0:
		dir = dir.normalized()
	position += dir * speed * delta
	position.x = clamp(position.x, 0, ssize.x)

func touched(area):
	if area.is_in_group("asteroid"):
		hit.emit()
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
