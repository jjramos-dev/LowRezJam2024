extends CharacterBody2D


@export var  SPEED = 300.0
@export var  JUMP_VELOCITY = 5.0

@export var gravedad=Vector2(0,10)
var _agarre=null
var _saltador=null

enum ESTADO {SALTANDO,CAYENDO,BARRA,PARADO,SALTADOR}
var estado=ESTADO.SALTANDO
var maxima_altura=0

func _ready():
	estado=ESTADO.SALTANDO

func _physics_process(delta):
	# Add the gravity.
	#if is_on_floor() or is_on_wall():
	#	estado=ESTADO.PARADO
		
	match estado:
		ESTADO.SALTANDO:
			if (not is_on_floor()) and (not is_on_wall()):
				velocity += gravedad * delta
			else:
				#estado=ESTADO.PARADO
				# $Timer.start(randf_range(2,4))
				# velocity.x=(1-randi(2))*randf_range(-1,1)*JUMP_VELOCITY
				velocity.x=((1-randi_range(0,2)))*JUMP_VELOCITY/4.0
				#
				## Si se para...
				if absf(velocity.y)<1:
					velocity.y = -JUMP_VELOCITY # *randf_range(0.8,1.5)
		
			move_and_slide()
			
		ESTADO.BARRA:
			if _agarre!=null:
				global_position=_agarre.global_position
		
		ESTADO.SALTADOR:
			if _saltador!=null:
				global_position=_saltador.global_position
				
		
		ESTADO.PARADO:
			pass
			
func impulsar_arriba(impulso):
	velocity.y=-absf(velocity.y)*impulso
	# velocity.x=randf_range(-1,1)*JUMP_VELOCITY
	velocity.x=((1-randi_range(0,2)))*JUMP_VELOCITY/4.0
	
func colgar(agarre):
	estado=ESTADO.BARRA
	_agarre=agarre


func colocar(saltador):
	estado=ESTADO.SALTADOR
	_saltador=saltador
	

#func _on_input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton:
		#estado=ESTADO.SALTANDO
		#_agarre.desagarrar(self)


func _on_timer_timeout():
	velocity.x=randf_range(-1,1)*JUMP_VELOCITY
	velocity.y = -JUMP_VELOCITY # *randf_range(0.8,1.5)
		
	estado=ESTADO.SALTANDO

func nadar(cuba):
	queue_free()

func impulsar(velocidad):
	velocity=velocidad
	estado=ESTADO.SALTANDO
