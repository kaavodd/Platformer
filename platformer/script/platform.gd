extends RigidBody2D
export (int) var time = 1
export var longueur = Vector2(0,-800)
func _ready():
	move()

func move():
	$Tween.interpolate_property(
		self,
		"position",
		global_position,
		global_position + longueur , 
		time,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)
	$Tween.start()
func _on_Tween_tween_completed(_object, _key):
	longueur *= -1
	move()
