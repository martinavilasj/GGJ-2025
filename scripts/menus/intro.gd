extends Control

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/nivel1.tscn")
	



func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/nivel1.tscn")
