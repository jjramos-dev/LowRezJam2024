extends CharacterBody2D

signal puntuar(evento,pulga)

@export var  SPEED = 300.0
@export var  JUMP_VELOCITY = 5.0
@export var gravedad=Vector2(0,10)
@export var ritmo=15
@export var pulga_radio=3
@export var MAXIMA_ALTURA=50
@export var suelo_y=51

var _agarre=null
var _saltador=null

enum ESTADO {SALTANDO,CAYENDO,BARRA,PARADO,SALTADOR,PIRUETA}
var estado=ESTADO.SALTANDO
var maxima_altura=-10

func _ready():
	estado=ESTADO.SALTANDO
	#estado=ESTADO.PIRUETA
	#velocity=Vector2(0.3,-0.2)*JUMP_VELOCITY

func _physics_process(delta):
	# Add the gravity.
	#if is_on_floor() or is_on_wall():
	#	estado=ESTADO.PARADO
	$Pulga.position.x=0
	$CollisionShape2D.position.x=0
	
	match estado:
		ESTADO.PIRUETA:
						
			$Pulga.position.x=pulga_radio
			$CollisionShape2D.position.x=pulga_radio
			
			if (not is_on_floor()) and (not is_on_wall()):
				velocity += gravedad * delta
			else:
				estado=ESTADO.SALTANDO
				rotation=0
		
			rotate(delta*(ritmo))
			move_and_slide()
			
			comprobar_altura()
			
		ESTADO.SALTANDO:

			if (not is_on_floor()) and (not is_on_wall()):
				velocity += gravedad * delta
			else:
				#estado=ESTADO.PARADO
				# $Timer.start(randf_range(2,4))
				# velocity.x=(1-randi(2))*randf_range(-1,1)*JUMP_VELOCITY
				
				if is_on_floor() and maxima_altura>MAXIMA_ALTURA and global_position.y >= suelo_y:
						emit_signal("puntuar","estrellado",self)
						print("estrellado")
						process_mode = Node.PROCESS_MODE_DISABLED
				else:
					velocity.x=((1-randi_range(0,2)))*JUMP_VELOCITY/4.0
				#
				## Si se para...
					if absf(velocity.y)<1:
						velocity.y = -JUMP_VELOCITY # *randf_range(0.8,1.5)
		
			move_and_slide()
			
			comprobar_altura()
			
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
	velocity.x=0
	estado=ESTADO.SALTANDO
	puntuar.emit("rebote",self)
	
func impulsar_derecha(impulso):
	velocity.y=-absf(velocity.y)*impulso
	# velocity.x=randf_range(-1,1)*JUMP_VELOCITY
	velocity.x=JUMP_VELOCITY/4.0
	estado=ESTADO.SALTANDO
	puntuar.emit("rebote",self)
	
func impulsar_izquierda(impulso):
	velocity.y=-absf(velocity.y)*impulso
	# velocity.x=randf_range(-1,1)*JUMP_VELOCITY
	velocity.x=-JUMP_VELOCITY/4.0
	estado=ESTADO.SALTANDO
	puntuar.emit("rebote", self)
		
func colgar(agarre):
	
	if estado==ESTADO.PIRUETA:
		# print("----- acrobacia-----")
		puntuar.emit("acrobacia",self)
		
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
	puntuar.emit("rebote")

func pirueta(direccion):
	estado=ESTADO.PIRUETA
	velocity=direccion*JUMP_VELOCITY
	_agarre=null

func achicharra():
	print("Achicharrada")
	emit_signal("puntuar","achicharra",self)
	queue_free()
	
func comprobar_altura():

	# print(str(64-global_position.y)+" -> "+str(maxima_altura))
	if 64-global_position.y>maxima_altura:
		maxima_altura=64-global_position.y
		# print("altura: "+str(maxima_altura))
