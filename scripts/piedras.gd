extends Area2D

@onready var static_body_2d: StaticBody2D = $"../StaticBody2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 150.0 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("suelo"):
		queue_free()
	elif body.is_in_group("player"):
		body.disminuir_oxigeno(5)
		queue_free()
