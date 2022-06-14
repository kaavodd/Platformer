extends "res://script/ennemi.gd"

func _ready():
	add_to_group("ennemi")

func _physics_process(delta):
	var player = get_parent().get_node("player")
	var direction = (player.position -position).normalized() #la longueur du vecteur à 1
	position += direction * vitesse * delta
	if position > player.position:
		$Sprite.flip_h = true

	if position < player.position:
		$Sprite.flip_h = false
