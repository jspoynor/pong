extends Node2D

var scores = [0, 0]
@onready var ball = $ball
@onready var player_1_score = $CanvasLayer/player1Score
@onready var player_2_score = $CanvasLayer/player2Score
@onready var count_down = $AnimationPlayer/countDown
@onready var animation_player = $AnimationPlayer
@onready var score_sound = $score

func _ready():
	count_down.visible = false
	_reset_ball()

func _add_score_p1():
	scores[0] += 1
	player_1_score.text = str(scores[0])
	print('P1: ', scores[0], '   P2: ', scores[1])
	
func _add_score_p2():
	scores[1] += 1
	player_2_score.text = str(scores[1])
	print('P1: ', scores[0], '   P2: ', scores[1])


func _on_left_zone_body_entered(body):
	_add_score_p2()
	score_sound.play()
	_reset_ball()

func _on_right_zone_body_entered(body):
	_add_score_p1()
	score_sound.play()
	_reset_ball()

func _reset_ball():
	ball.set_physics_process(false)
	ball.visible = false
	if (scores.max() < 5) or (scores[0] == scores[1]):
		await get_tree().create_timer(2.0).timeout
		count_down.visible = true
		animation_player.play("countdown")
		await get_tree().create_timer(1.6).timeout
		count_down.visible = false
	elif scores.max() > 5:
		if scores[0] > (scores[1] +1):
			await get_tree().create_timer(2.0).timeout
			count_down.visible = true
			count_down.text = 'P1 Wins!'
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
		elif scores[1] > (scores[0] + 1):
			await get_tree().create_timer(2.0).timeout
			count_down.visible = true
			count_down.text = 'P2 Wins!'
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
		else:
			await get_tree().create_timer(2.0).timeout
			count_down.visible = true
			animation_player.play("matchPoint")
			await  get_tree().create_timer(2.9).timeout
			count_down.visible = false
	else:
		await get_tree().create_timer(2.0).timeout
		count_down.visible = true
		animation_player.play("matchPoint")
		await  get_tree().create_timer(2.9).timeout
		count_down.visible = false
	animation_player.play("RESET")
	ball.set_physics_process(true)
	ball.visible = true
	ball.angle = ball.side_cur + ball._rand_angle()
	ball.angle = (ball.angle * PI) / 180
	ball.acceleration = 0 + ((scores[0] + scores[1]) / 2) * 70
	ball.position.x = 0
	ball.position.y = 0
