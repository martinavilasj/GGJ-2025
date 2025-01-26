extends RigidBody2D

enum PlayerState { IDLE, RUN, JUMP, FALL, HURT}

var  _state: PlayerState = PlayerState.IDLE

@export var velocidad_inicial = 20
var velocidad = velocidad_inicial
@export var jump_velocity_inicial = 200
var jump_velocity = jump_velocity_inicial

var oxigeno = 100
var disminuidor_oxigeno = 0.4
@onready var timer_oxigeno = $Timer_Oxigeno
@onready var barra_oxigeno = $CanvasLayer/Control/ProgressBar
@onready var timer_ralentizar: Timer = $Timer_ralentizar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var ralentizado = false

func _ready() -> void:
	timer_oxigeno.start()

func _physics_process(delta: float) -> void:
	var direccion = Vector2.ZERO
	
	if get_colliding_bodies().size()>0 and Input.is_action_pressed("ui_right"):
		direccion = Vector2(1 , 0)
		animated_sprite_2d.flip_h = false
	elif get_colliding_bodies().size()>0 and Input.is_action_pressed("ui_left"):
		direccion = Vector2(-1 , 0)
		animated_sprite_2d.flip_h = true
	else:
		direccion = Vector2(0, 0)
		
	if get_colliding_bodies().size()>0 and Input.is_action_pressed("ui_accept"):
		direccion = Vector2(0 , -1)
		apply_central_impulse(direccion * jump_velocity)

	apply_central_impulse(direccion * velocidad)
	calculate_states()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	barra_oxigeno.value = oxigeno
	animated_sprite_2d.rotation = -rotation

func ralentizar(tiempo,reduccion):
	if not ralentizado:
		timer_ralentizar.start(tiempo)
		linear_velocity *= reduccion
		velocidad *= reduccion
		jump_velocity *= reduccion
		ralentizado = true

func get_input() -> void:
	if Input.is_action_pressed("ui_left"):
		animated_sprite_2d.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		animated_sprite_2d.flip_h = false


func _on_timer_timeout() -> void:
	velocidad = velocidad_inicial
	jump_velocity = jump_velocity_inicial
	ralentizado = false

func _on_timer_oxigeno_timeout() -> void:
	if oxigeno > 0:
		oxigeno -= disminuidor_oxigeno
		timer_oxigeno.start()

func disminuir_oxigeno(valor: float):
	var resta = (oxigeno*valor)/100
	oxigeno -= resta

func calculate_states() -> void:
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") == true:
		set_state(PlayerState.RUN)
	else:
		set_state(PlayerState.IDLE)

func set_state(new_state: PlayerState) -> void:
	if new_state ==_state:
		return
	_state = new_state
	
	match _state:
		PlayerState.IDLE:
			animated_sprite_2d.play("idle")
		PlayerState.RUN:
			animated_sprite_2d.play("caminar")
		PlayerState.JUMP:
			animated_sprite_2d.play("salto")
		PlayerState.FALL:
			animated_sprite_2d.play("caida")
