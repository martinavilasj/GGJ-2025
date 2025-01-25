extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite_collision: CollisionShape2D = $CollisionShape2D
@onready var timer = $Timer

var initial_speed = 250
var speed = 250
var jump_vel = -300
var gravity = 300

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_vel
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

		
	if velocity.y > 0 or velocity.x > 0:
		animation.play("giro")
	elif velocity.x < 0:
		animation.play_backwards()
	elif velocity.y == 0:
		animation.pause()
		
	
	move_and_slide()

func ralentizar(tiempo: int, reduccion: int):
	timer.start(tiempo)
	speed -= reduccion

func _on_timer_timeout() -> void:
	speed = initial_speed
