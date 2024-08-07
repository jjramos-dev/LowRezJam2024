extends CharacterBody2D


@export var  SPEED = 300.0
@export var  JUMP_VELOCITY = 5.0

@export var gravedad=Vector2(0,10)
var _agarre=null

enum ESTADO {SALTANDO,CAYENDO,BARRA,PARADO}
var estado=ESTADO.SALTANDO

func _physics_process(delta):
	# Add the gravity.
	
	match estado:
		ESTADO.SALTANDO:
			if (not is_on_floor()) and (not is_on_wall()):
				velocity += gravedad * delta
			else:
				velocity.x=randf_range(-1,1)*JUMP_VELOCITY
	
				# Si se para...
				if absf(velocity.y)<1:
					velocity.y = -JUMP_VELOCITY # *randf_range(0.8,1.5)
		
			move_and_slide()
		ESTADO.BARRA:
			if _agarre!=null:
				global_position=_agarre.global_position
			
func impulsar_arriba(impulso):
	velocity.y=-absf(velocity.y)*impulso
	velocity.x=randf_range(-1,1)*JUMP_VELOCITY

func colgar(agarre):
	estado=ESTADO.BARRA
	_agarre=agarre
	print("colgando")


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		estado=ESTADO.SALTANDO
