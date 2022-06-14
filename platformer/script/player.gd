extends KinematicBody2D

var mouvement = Vector2()
export (int) var vitesse = 400
const gravite = 1500
const accel = 10
const vector = Vector2 (0 , -1)
var direction = 1
var can_shoot= true
var tir = preload("res://scene/player/tir.tscn")
var souris_pos =Vector2()


func _ready():
	$interface/VBoxContainer/vie.value = Global.vie

func _process(_delta):
	$interface/VBoxContainer/HBoxContainer/Score.text = str(Global.score)

func _physics_process(delta):
	menu()
	mouvement.y += gravite * delta
	mouvement.x = 0
	mouvements()
	mouvement = move_and_slide(mouvement , vector)
	$Position.look_at(get_global_mouse_position())

func mouvements():
	souris_pos = get_global_mouse_position()
	var tir_ligne= souris_pos - $Position.global_position
	var rotation = tir_ligne.angle()
	var droite = Input.is_action_pressed("droite")
	var gauche = Input.is_action_pressed("gauche")
	var sauter = Input.is_action_just_pressed("sauter")
	var tirer = Input.is_action_pressed("tirer")
	var dirx = int(droite) - int(gauche)
	if dirx == -1:
		mouvement.x -= vitesse
		$AnimatedSprite.flip_h = true
		$Position.position.x = -35
		direction = -1
		$AnimatedSprite.play("Run")
	elif dirx == 1:
		mouvement.x += vitesse
		$AnimatedSprite.flip_h = false
		direction = 1
		$Position.position.x = 35
		$AnimatedSprite.play("Run")
	else:
		mouvement.x =0
		$AnimatedSprite.play("idle")
	if sauter == true and is_on_floor():
		$AnimatedSprite.play("Jump")
		mouvement.y = -700
	if tirer and can_shoot:
		can_shoot = false
		$delais.start()
		$sound/tir.play()
		var b = tir.instance()
		b.start($Position.global_position,rotation)
		get_parent().add_child(b)

func _on_delais_timeout():
	can_shoot =true

func _on_hitbox_body_entered(body):
	if body.is_in_group("ennemi"):
		var collision_point = global_position - body.global_position
		mouvement.y = -500
		mouvement =move_and_slide(mouvement , vector)
		Global.vie += 10
		$interface/VBoxContainer/vie.value = Global.vie
	if Global.vie == 100:
		set_physics_process(false)
		$AnimatedSprite.play("Dead")
		$interface/AnimationPlayer.play("gameover")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func menu():
	if Input.is_action_just_pressed("menu"):
		get_tree().paused = true
		$interface/AnimationPlayer.play("menu")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		set_physics_process(false)

func _on_Button_pressed():
	get_tree().change_scene("res://scene/Niveau/Accueil_jeu.tscn")

func _on_Continuer_pressed():
	get_tree().paused = false
	$interface/AnimationPlayer.play("enlever_menu")
	set_physics_process(true)

func _on_Quitter_pressed():
	 get_tree().quit()

func _on_Option_pressed():
	get_tree().paused = true
	$interface/AnimationPlayer.play("option")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_physics_process(false)

func _on_Quitteroption_pressed():
	get_tree().paused = false
	set_physics_process(true)
	$interface/AnimationPlayer.play("enlever_option")

func _on_niveau_completed_body_entered(body):
	get_tree().paused = true
	set_physics_process(false)
	$interface/AnimationPlayer.play("Finir_niveau")

func _on_hitbox_area_entered(area):
	Global.get("array_lvl"+ str(Global.actuel_lvl)).append(area.get_path())
	if area.is_in_group('teleporteur'):
		pass
	if area.is_in_group('piece'):
		$sound/piece.play()
	if area.is_in_group('potion'):
		if Global.vie == 0:
			Global.vie -=0
		else:
			Global.vie -= 20
			$sound/potion.play()
			$interface/VBoxContainer/vie.value = Global.vie
		area.queue_free()
		
	if area.is_in_group('game_over'):
		pass


func _on_delais2_timeout():
	$CollisionShape2D.disabled = false
	
