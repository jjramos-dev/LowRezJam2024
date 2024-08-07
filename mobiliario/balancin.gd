extends Marker2D


@export var velocidad=20
var direccion=1
const GRAD2RAD=PI/180
@export var ritmo=1
@export var desfase=0
@export var max_pulgas=2
var n_pulgas=0

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
		if n_pulgas<max_pulgas:
			body.colgar($agarre)
			n_pulgas=n_pulgas+1

func _on_agarre_input_event(viewport, event, shape_idx):
	print("evento balancín")
	
func desagarrar(pulga):
	n_pulgas=n_pulgas-1
