extends Control

@onready var animacion: AnimationPlayer = $CanvasGroup/AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion.play("burbujas")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_nuevo_juego_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/nivel1.tscn")
	
func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/creditos.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
