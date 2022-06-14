extends KinematicBody2D

var speed = 500
var vel = Vector2()

func start(pos, dir):
	rotation = dir
	position = pos 
	vel += Vector2(speed , 0).rotated(rotation)
func _process(delta):
	var collision = move_and_collide(vel * delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit(20)
		queue_free()
