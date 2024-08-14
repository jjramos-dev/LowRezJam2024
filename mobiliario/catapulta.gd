extends Area2D

@export var impulso=Vector2(-5,-10)
var _pulga=null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		$AnimationPlayer.play("catapultar")
		print("catapulta")

func impulsar(pulga):
	if _pulga!=null:
		_pulga.impulsar(impulso)
		_pulga=null

func _on_body_entered(body):
	if body.is_in_group("pulga"):
		body.colocar($saltador)
		_pulga=body
