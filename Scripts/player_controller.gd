extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Resource) var debugLabel;
export (int) var acceleration = 200
export (int) var deacceleration = 180
export (float) var rotation_speed = 1.5
export (float) var startingFuel = 300
# All movements costs are fuel/seconds
export (float) var shortRangeCostPerSecond = 5;
export (float) var longRangeCostPerSecond = 10;
export (float) var movementCostPerSecond = 1;
onready var animator = $ShipAnimation
onready var longRangeSensor = $LongRangeSensor
onready var shortRangeSensor = $ShortRangeSensor

var velocity = Vector2()
var rotation_dir = 0
var isLongRangeSensorActive = false;
var isShortRangeSensorActive = false;
var currentFuel = 0;

func _ready():
	currentFuel = startingFuel;
	longRangeSensor.hide();
	shortRangeSensor.hide();

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
	if Input.is_action_pressed("short_range_sensor"):
		isShortRangeSensorActive = true
	elif Input.is_action_pressed("long_range_sensor"):
		isShortRangeSensorActive = false;
		isLongRangeSensorActive = true;

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	var fuelConsumption = 0;
	if isShortRangeSensorActive:
		shortRangeSensor.show()
		longRangeSensor.hide()
		fuelConsumption += shortRangeCostPerSecond * delta;
	elif isLongRangeSensorActive:
		longRangeSensor.show();
		shortRangeSensor.hide();
		fuelConsumption += longRangeCostPerSecond * delta;
	else:
		longRangeSensor.hide();
		shortRangeSensor.hide()
#	print_debug(velocity)
	if(velocity.x != 0 && velocity.y !=0):
		fuelConsumption += movementCostPerSecond * delta;
		animator.play('Flying')
	else:
		animator.play('Idle')
	print_debug(currentFuel)
