extends CharacterBody2D

const SPEED = 300.0
var acceleration = 0
var angle : float = 0
var constrain : int = 60
var sides = [0, 180]
var side_cur : int
@onready var player_hit = $"../playerHit"
@onready var border_hit = $"../borderHit"
@onready var sprite_2d = $Sprite2D

func _ready():
	#generate a random angle within constrains
	sprite_2d.modulate.a = 0.2
	side_cur = sides[randi() % 2]
	angle = side_cur + _rand_angle()
	# convert degrees to radians
	angle = (angle * PI / 180)

func _physics_process(delta):
	if acceleration >= 7 * 20:
		constrain = 35
	
	if is_on_wall():
		player_hit.play()
		acceleration += 5
		if side_cur == sides[0]:
			side_cur = sides[1]
			angle = side_cur + _rand_angle()
			angle = (angle * PI) / 180
		elif side_cur == sides[1]:
			side_cur = sides[0]
			angle = side_cur + _rand_angle()
			angle = (angle * PI) / 180
	
	if is_on_floor() or is_on_ceiling():
		border_hit.play()
		acceleration += 7
		angle = side_cur + _rand_angle()
		angle = (angle * PI) / 180
	
	if acceleration >= 9000:
		acceleration = 9000
	# set velocity to speed and angle
	velocity = Vector2((SPEED) * cos(angle), (SPEED) * sin(angle))
	move_and_slide()

func _rand_angle():
	return -constrain + (randi() % (constrain * 2))
