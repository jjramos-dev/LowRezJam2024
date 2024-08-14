extends Control

var i_mensaje=0
var mensajes=["The End! ","Come back soon!\n ","Please, bring your own bugs.\n ","This is buggy.\n ","Press here to exit!\n ","No real fleas were harmed\n ","We love ants...\n ","Made with love and beer.\n ", "it may contain traces of fish.\n ", "What are you looking for, Christmas?\n "]
# Called when the node enters the scene tree for the first time.
func _ready():
	i_mensaje=0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func mostrar_fin():
	i_mensaje=0
	$mensaje.text=mensajes[i_mensaje%mensajes.size()]
	$AnimationPlayer.play("the_end")

func _on_label_gui_input(event):
	print("tocado...")
	if event is InputEventMouseButton:
		get_tree().change_scene_to_file("res://menus/creditos.tscn")

func cambiar_mensaje():
	i_mensaje=i_mensaje+1
	$mensaje.text=mensajes[i_mensaje%mensajes.size()]
	
func asignar_estadisticas(estadisticas):
	$Pulgas.text="+ Fleas:\nalive  x"+str(estadisticas.alive)+"\nsmashed x"+str(estadisticas.smashed)+"\nsmoked: x"+str(estadisticas.smoked)


func _on_area_2d_input_event(viewport, event, shape_idx):
	_on_label_gui_input(event)


func _on_button_button_up():
	get_tree().change_scene_to_file("res://menus/creditos.tscn")
