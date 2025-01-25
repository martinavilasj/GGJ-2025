extends RigidBody2D

var velocidad_inicial = 20
var velocidad = 20
var jump_velocity_inicial = 200
var jump_velocity = 250

@onready var timer: Timer = $Timer
var ralentizado = false

func _ready() -> void:
	pass # Replace with function body.

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
	pass

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
