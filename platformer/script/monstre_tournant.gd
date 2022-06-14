extends "res://script/ennemi.gd"
const vector = Vector2 (0 , -1)

func _physics_process(_delta):
	mouvement.x = dirx * vitesse
	mouvement.y = 100
	mouvement = move_and_slide(mouvement , vector)
	if is_on_wall() or $RayCast2D.is_colliding()==false:
		dirx *= -1
		$RayCast2D.position.x *= -1
