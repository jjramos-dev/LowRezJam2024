extends Node2D

@export var velocidad=500

var posicion_trampolin:Vector2=Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	posicion_trampolin=$Objetos/Trampolin.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var signo=0
	
	if Input.is_action_pressed("accionar"):
		var posicion=get_viewport().get_mouse_position()
		if posicion.y>$InicioZonaControlTrampolin.position.y:
			posicion_trampolin=posicion
		
	if $Objetos/Trampolin.position.x-posicion_trampolin.x<-5:
		signo=1
	elif $Objetos/Trampolin.position.x-posicion_trampolin.x>5:
		signo=-1
	else:
		signo=0
	
	if signo!=0:
		$Objetos/Trampolin.velocity.x=signo*velocidad
		$Objetos/Trampolin.move_and_slide()
