extends Node2D

var mensajes=["+Designing: Abel and jjramos\n+Coding: jjramos", "+Music: \"Circus Tent\" Kevin MacLeod (incompetech.com), CC BY 4.0", "+ Font: \"geompixel\" by liquidev, CC0 1.0"]
var i_mensaje=0

# Called when the node enters the scene tree for the first time.
func _ready():
	$creditos/texto.text=mensajes[i_mensaje]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cambiar_mensaje():
	i_mensaje=i_mensaje+1
	$creditos/texto.text=mensajes[i_mensaje%mensajes.size()]	

func _on_button_button_up():
	get_tree().change_scene_to_file("res://menus/portada.tscn")
