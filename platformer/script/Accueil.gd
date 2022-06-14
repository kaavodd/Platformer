extends TextureRect

var niveau1 = preload("res://scene/Niveau/scene.tscn")

func _on_Start_pressed():
	get_tree().change_scene_to(niveau1)

func _on_Quitter_pressed():
	get_tree().quit()
