extends RigidBody2D

@export var velocidad_inicial = 20
var velocidad = velocidad_inicial
@export var jump_velocity_inicial = 200
var jump_velocity = jump_velocity_inicial

var oxigeno = 100
var disminuidor_oxigeno = 0.4
@onready var timer_oxigeno = $Timer_Oxigeno
@onready var barra_oxigeno = $CanvasLayer/Control/ProgressBar

@onready var timer: Timer = $Timer
var ralentizado = false

func _ready() -> void:
	timer_oxigeno.start()

func _physics_process(delta: float) -> void:
	var direccion = Vector2.ZERO
	
	if get_colliding_bodies().size()>0 and Input.is_action_pressed("ui_right"):
		direccion = Vector2(1 , 0)
	elif get_colliding_bodies().size()>0 and Input.is_action_pressed("ui_left"):
		direccion = Vector2(-1 , 0)
	else:
		direccion = Vector2(0, 0)
		
	if get_colliding_bodies().size()>0 and Input.is_action_pressed("ui_accept"):
		direccion = Vector2(0 , -1)
		apply_central_impulse(direccion * jump_velocity)

	apply_central_impulse(direccion * velocidad)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	barra_oxigeno.value = oxigeno

func ralentizar(tiempo,reduccion):
	if not ralentizado:
		timer.start(tiempo)
		linear_velocity *= reduccion
		velocidad *= reduccion
		jump_velocity *= reduccion
		ralentizado = true


func _on_timer_timeout() -> void:
	velocidad = velocidad_inicial
	jump_velocity = jump_velocity_inicial
	ralentizado = false

func _on_timer_oxigeno_timeout() -> void:
	pass # Replace with function body.
