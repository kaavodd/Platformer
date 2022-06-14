extends KinematicBody2D


var mouvement = Vector2()
var vitesse = 150
const gravite = 1000
const accel = 10
var dirx = 1
var sauter = false
var vie = 100

func _ready():
	add_to_group("ennemi")

func hit(dommage):
	vie -= dommage
	if vie <=0:
		queue_free()
