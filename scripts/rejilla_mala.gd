extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D

@export var ralentizar: float = 0.5
@export var tiempo_ralentizar: int = 5

@onready var animacion: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion.play("burbujas")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.ralentizar(tiempo_ralentizar,ralentizar)
