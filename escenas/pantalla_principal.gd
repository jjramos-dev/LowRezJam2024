extends Node2D

@export var velocidad=500

var total_puntuacion=0

var posicion_trampolin:Vector2=Vector2(0,0)
var en_juego=true

var estadisticas={"smashed":0,"smoked":0,"alive":0}

const PUNTOS=preload("res://Componentes/puntos.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	posicion_trampolin=$InicioZonaControlTrampolin/Trampolin.global_position
	$Control.comenzar()
	$GeneradorPulgas.suelo_y=$InicioZonaControlTrampolin.global_position.y
	en_juego=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var signo=0
	
	pass
	
	#if Input.is_action_pressed("accionar"):
		#var posicion=get_viewport().get_mouse_position()
		#if posicion.y>$InicioZonaControlTrampolin.position.y:
			#posicion_trampolin=posicion
		#
	#if $Objetos/Trampolin.position.x-posicion_trampolin.x<-5:
		#signo=1
	#elif $Objetos/Trampolin.position.x-posicion_trampolin.x>5:
		#signo=-1
	#else:
		#signo=0
	#
	#if signo!=0:
		#$Objetos/Trampolin.velocity.x=signo*velocidad
		#$Objetos/Trampolin.move_and_slide()


func _on_trampolin_puntuar(evento, pulga):
	var puntos=PUNTOS.instantiate()
	var valor=0
	add_child(puntos)
	
	match evento:
		"rebote":
			valor=2
		"cuba":
			valor=30
			estadisticas.alive=estadisticas.alive+1
		"balancin":
			valor=5
		"achicharra":
			valor=-10
			estadisticas.smoked=estadisticas.smoked+1
		"estrellado":
			valor=-5
			estadisticas.smashed=estadisticas.smashed+1
		"acrobacia":
			valor=40

	puntos.asignar_valor(valor)
	puntos.global_position=pulga.global_position
	
	total_puntuacion=total_puntuacion+valor	
	
	$Control.asignar_valor(total_puntuacion)
	$Limites/Plancha/Trampolin.process_mode=Node.PROCESS_MODE_DISABLED
				
func conecta_achicharrar(pulga):
	pulga.puntuar.connect(_on_trampolin_puntuar)


func _on_control_tiempo_expirado():
	if en_juego:
		$Final.visible=true
		$Final.mostrar_fin()
		$Final.asignar_estadisticas(estadisticas)
		
		$GeneradorPulgas.process_mode=Node.PROCESS_MODE_DISABLED
		en_juego=false

func acelerar():
	Engine.time_scale=2.0
	$Control/Temporizador.add_theme_color_override("font_color",Color("#94555B"))
	# $AudioStreamPlayer.set


func _on_balancin_puntuar(evento, pulga):
	_on_trampolin_puntuar(evento, pulga)


func _on_balancin_2_puntuar(evento, pulga):
	_on_balancin_puntuar(evento, pulga)
