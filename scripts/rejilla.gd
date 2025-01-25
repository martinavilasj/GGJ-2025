extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

@export var frecuencia_apertura: int = 5
@export var tiempo_relentizado: int = 5
@export var velocidad_relentizado: int = 100

@onready var burbujas = $burbujas



# Controlar si la rejilla esta abierta o no 
var activo = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(frecuencia_apertura)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if activo:
		collision.disabled = false
		burbujas.visible = true
	else:
		collision.disabled = true
		burbujas.visible = false

func _on_timer_timeout() -> void:
	activo = not activo
	timer.start(frecuencia_apertura)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.relentizar(tiempo_relentizado,velocidad_relentizado)
