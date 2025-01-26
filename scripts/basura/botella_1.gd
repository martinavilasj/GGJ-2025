extends Area2D

@export var disminuidor: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.audio_dano.play()
		body.disminuir_oxigeno(disminuidor)
		queue_free()
