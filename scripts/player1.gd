extends StaticBody2D

const MOVE_SPEED : int = 500
@onready var ball = $"../ball"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("player1-up"):
		position.y += -(MOVE_SPEED + (ball.acceleration / 6)) * delta
	elif Input.is_action_pressed("player1-down"):
		position.y += (MOVE_SPEED + (ball.acceleration / 6)) * delta
		
	position.y = clamp(position.y, -230, 230)
