extends Marker2D

signal puntuar(evento,pulga)

@export var velocidad=20
const GRAD2RAD=PI/180
@export var ritmo=1
@export var desfase=0
@export var max_pulgas=2
@export var salto_derecha=Vector2(0.3,-0.2)
@export var salto_izquierda=Vector2(-0.3,-0.2)
@export var flipado=false
var n_pulgas=0
var pulgas=[]



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	rotation=cos(Time.get_ticks_msec()/(ritmo*1000.0))
	#rotate(velocidad*delta*GRAD2RAD)

func _on_area_2d_body_entered(body):
	if body.is_in_group("pulga"):
		print(n_pulgas)
		if n_pulgas<max_pulgas:
			body.colgar($agarre)
			n_pulgas=n_pulgas+1
			pulgas.append(body)
			
			#if body.estado==body.ESTADO.PIRUETA:
				#print("Pirueta")
			#else:
				#print("llegado")
			
			emit_signal("puntuar","balancin",body)
			# print(str(body.estado)+" "+str(body.ESTADO.PIRUETA))

func _on_agarre_input_event(viewport, event, shape_idx):
	# print("evento balancín")
	if event is InputEventMouseButton:
		var pulga=pulgas.pop_back()
		if pulga!=null:
			desagarrar(pulga)
			
			var direccion_pirueta=0
			
			if flipado:
				direccion_pirueta=pulga.global_position.x-global_position.x
			else:
				direccion_pirueta=-pulga.global_position.x+global_position.x
				
			if direccion_pirueta<0:
				pulga.pirueta(salto_derecha)
			else:
				pulga.impulsar(salto_izquierda)
				
func desagarrar(pulga):
	n_pulgas=n_pulgas-1
