extends Control


@export var velocidad=10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func asignar_valor(valor):
	var signo=""
	if valor>0:
		signo="+"
	$Label.text=signo+str(valor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y=position.y-velocidad*delta
	# $Label.self_modulate=$Label.self_modulate
	# $Label.add_theme_color_override("font_color",)

func _on_timer_timeout():
	queue_free()
