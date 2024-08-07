extends CharacterBody2D


@export var IMPULSO=1.5
func _physics_process(delta):
	pass


func _on_detectar_colision_body_entered(body):
	if body.is_in_group("pulga"):
		body.impulsar_arriba(IMPULSO)
