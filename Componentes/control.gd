extends Control

signal tiempo_expirado()

@export var temporizador=60
var han_pasado=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func asignar_valor(valor):
	$MarginContainer/Contador.text="%03d" % valor

func comenzar():
	$Timer.start(1)
	han_pasado=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	
	han_pasado=han_pasado+1
	
	var pasados=temporizador-han_pasado
	var minutos=pasados/60
	var segundos=pasados%60

	if pasados<0:
		tiempo_expirado.emit()
	else:
		$Temporizador.text=("%02d" % minutos)+":"+("%02d" % segundos)
		$Timer.start(1)
