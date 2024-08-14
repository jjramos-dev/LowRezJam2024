extends CharacterBody2D

@export var IMPULSO=1.2
@export var offset_y=51
@export var offset_x_trampolin=2

signal puntuar(evento,pulga)

func _physics_process(delta):
	if Input.is_action_pressed("accionar"):
		var posicion=get_viewport().get_mouse_position()
		if posicion.y>position.y+offset_y:
			position.x=posicion.x


func _on_detectar_colision_body_entered(body):
	if body.is_in_group("pulga"):
		if body.global_position.x<global_position.x-offset_x_trampolin:
			body.impulsar_izquierda(IMPULSO)
		elif  body.global_position.x>global_position.x+offset_x_trampolin: 
			body.impulsar_derecha(IMPULSO)
		else:
			body.impulsar_arriba(IMPULSO)
		
		$AnimationPlayer.play("rebote")
		
