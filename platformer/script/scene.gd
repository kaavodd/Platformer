extends Node2D

func _ready():
	match Global.sens:
		Global.LEFT:
			$player.global_position = $Position2D.global_position
			$player/AnimatedSprite.flip_h = true
	for i in Global.get("array_lvl"+ str(Global.actuel_lvl)):
		print(i)
		get_node(i).queue_free()

func _on_retour_arriere_body_entered(body):
	Global.set_sens(Global.LEFT)
	get_tree().change_scene("res://scene/Niveau/scene.tscn")
	Global.actuel_lvl -=1

func _on_niveau3_body_entered(body):
	get_tree().change_scene("res://scene/Niveau/niveau3.tscn")
	Global.actuel_lvl +=1

func _on_finir_niveau_body_entered(body):
	get_tree().change_scene("res://scene/Niveau/niveau2.tscn")
	Global.actuel_lvl +=1
func _on_Area2D_body_entered(body):
	$player/interface/AnimationPlayer.play("gameover")
	set_physics_process(false)

