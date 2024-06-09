extends Node2D

@onready var button = $background/Button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if Input.is_action_pressed("spacebar"):
		get_tree().change_scene_to_file("res://scenes/mainGame.tscn")


func _on_button_button_down():
	get_tree().change_scene_to_file("res://scenes/mainGame.tscn")
