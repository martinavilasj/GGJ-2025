extends Control

@onready var animacion: AnimationPlayer = $CanvasGroup/AnimationPlayer
@onready var timer: Timer = $Timer
@onready var disclaimer: TextureRect = $disclaimer

@export var tiempo_disclaimer: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion.play("burbujas")
	$AnimationPlayer.play("inicio")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/menus/intro.tscn")


func _on_nuevo_juego_pressed() -> void:
	start_game()
	
func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/creditos.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()

func start_game() -> void:
	timer.start(tiempo_disclaimer)
	disclaimer.visible = true

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/intro.tscn")
