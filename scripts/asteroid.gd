class_name Asteroid extends Area2D

@onready var collision_mesh = $AICollisionMesh
@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

enum AsteroidSize{LARGE}
@export var size := AsteroidSize.LARGE
@export var movement_vector := Vector2(0, -1)
@export var speed = randf_range(50, 100)

func _on_body_entered(body):
	print("ai entered asteroid body")

func _on_area_entered(area):
	print("ai entered asteroid area")

func _ready():
	rotation = randf_range(0, 2*PI)
	sprite.texture = preload("res://assets/textures/meteorGrey_big4.png")
	cshape.set_deferred("shape", preload("res://resources/asteroid_cshape_large.tres"))

func _physics_process(delta):
	# move asteroid to other side of screen
	global_position += movement_vector.rotated(rotation) * speed * delta

	var radius = cshape.shape.radius
	var screen_size = get_viewport_rect().size
	if (global_position.y+radius) < 0:
		global_position.y = (screen_size.y+radius)
	elif (global_position.y-radius) > screen_size.y:
		global_position.y = -radius
	if (global_position.x+radius) < 0:
		global_position.x = (screen_size.x+radius)
	elif (global_position.x-radius) > screen_size.x:
		global_position.x = -radius
