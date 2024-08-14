extends Node2D


@export var max_n_pulgas=20	
@export var periodo_generacion=5
@export var suelo_y=51
const PULGA=preload("res://personajes/pulga.tscn")
var n_pulgas=0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if n_pulgas<max_n_pulgas:
		var pulga=PULGA.instantiate()
		add_child(pulga)
		n_pulgas=n_pulgas+1
		conectar_pulga_a_controlador(pulga)
		pulga.suelo_y=suelo_y
	$Timer.start(periodo_generacion)
	
func conectar_pulga_a_controlador(pulga):
	var raiz=get_node("/root/PantallaPrincipal")
	raiz.conecta_achicharrar(pulga)
