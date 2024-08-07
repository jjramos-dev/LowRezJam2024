extends Node2D


@export var max_n_pulgas=5
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
	
	$Timer.start(10)
	
