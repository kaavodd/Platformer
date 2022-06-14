extends "res://script/ennemi.gd"


func _on_Timer_timeout():
	var m = int(rand_range(0,100))
	if m <50:
		dirx = -1
	elif m > 50:
		dirx = 1
	else:
		dirx = 0
	var j = int(rand_range(0,10))
	if j < 6:
		sauter = true
	else:
		sauter = false

func _physics_process(delta):
	mouvement.y += gravite * delta
	mouvement.x = 0
	move_loop()
	move_and_slide(mouvement , Vector2(0 , -1))

func move_loop():
	if is_on_wall():
		dirx *= -1 

	if dirx == -1:
		mouvement.x -= vitesse
		$Sprite.flip_h = true
		$anim.play("walk")
	elif dirx == 1:
		mouvement.x += vitesse
		$Sprite.flip_h = false
		$anim.play("walk")

	else:
		mouvement.x =0
		$anim.play("idle")
	if sauter == true and is_on_floor():
		mouvement.y = -400
