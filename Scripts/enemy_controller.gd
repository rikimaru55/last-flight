extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var enemyPathFollow = $EnemyPathFollow
onready var enemyGhostPathFollow = $EnemyGhostPathFollow
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.
func _process(delta):
	enemyPathFollow.set_offset(enemyPathFollow.get_offset() + 50 * delta)
	enemyGhostPathFollow.set_offset(enemyPathFollow.get_offset() - rng.randi_range(100,300))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
