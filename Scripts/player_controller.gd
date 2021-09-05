extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Resource) var debugLabel;
export (int) var acceleration = 200
export (int) var deacceleration = 180
export (float) var rotation_speed = 1.5

var velocity = Vector2()
var rotation_dir = 0

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("turn_clockwise"):
		rotation_dir += 1
	if Input.is_action_pressed("turn_counter_clockwise"):
		rotation_dir -= 1
	if Input.is_action_pressed("deaccelerate"):
		velocity = Vector2(-deacceleration, 0).rotated(rotation)
	if Input.is_action_pressed("accelerate"):
		velocity = Vector2(acceleration, 0).rotated(rotation)

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
