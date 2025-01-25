extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite_collision: CollisionShape2D = $CollisionShape2D

var speed = 150

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_axis("ui_left","ui_right")
	var moverIzqDer = Input.get_axis("ui_left","ui_right")
	var moverArrAba = Input.get_axis("ui_up","ui_down")
	var moverAmbas = Vector2(moverIzqDer,moverArrAba)
	velocity= moverAmbas.normalized() * speed
	
	
	# Add the gravity.
	if not is_on_floor() and not moverArrAba:
		velocity += get_gravity() * delta * 8
	
	if velocity.y > 0 or velocity.x > 0:
		print(velocity)
		animation.play("giro")
	elif velocity.x < 0:
		animation.play_backwards()
	elif velocity.y == 0:
		animation.pause()
		
	
	move_and_slide()
