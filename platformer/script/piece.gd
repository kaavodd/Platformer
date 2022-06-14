extends Area2D

export (int) var time = 1
func _on_piece_body_entered(_body):
	Global.score +=1
	$CollisionShape2D.disabled = true
	$Tween.interpolate_property(
		self,
		"position",
		position,
		Vector2(position.x - 500 , position.y - 300),
		time,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	$Tween.start()
	yield($Tween, 'tween_completed')
	queue_free()
