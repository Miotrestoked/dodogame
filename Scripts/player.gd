extends Area2D

@export var speed = 400
var screen_size
var sprite_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	var size = $PlayerSprite.texture.get_size()
	# Divide by 2 since position is in the middle of character
	sprite_size = Vector2(size * $PlayerSprite.scale) / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	var input = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input * speed
	
	if velocity.length() > 0:
		# Normalize velocity so diagonal movement is the same speed as regular
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	# Keep character within screen bounds
	position = position.clamp(Vector2.ZERO + sprite_size, screen_size - sprite_size)
