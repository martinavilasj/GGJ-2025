extends Node2D

@export var escena_piedra: PackedScene

@onready var canvasmodulate: CanvasModulate = $CanvasModulate
@onready var animacion_canvas: AnimationPlayer = $AnimationCanvas

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_piedra() -> void:
	var nueva_piedra = escena_piedra.instantiate()
	var xpos: float = randf_range(70, 5300)
	nueva_piedra.position = Vector2(xpos, -50)
	add_child(nueva_piedra)
	


func _on_timer_piedras_timeout() -> void:
	spawn_piedra()


func _on_zona_oscura_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animacion_canvas.play("canvas")
		body.luz.enabled = true
		


func _on_zona_clara_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animacion_canvas.play_backwards("canvas")
		#body.luz.enabled = false
