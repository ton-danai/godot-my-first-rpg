extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 =  Vector2.ZERO
var move_speed : float = 100.0
var state : String = "idle"

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * move_speed
	move_and_slide()
	
	if set_state() || set_direction() :
		update_animation()

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false

	var new_direction := cardinal_direction

	# ถ้าอยาก “ล็อก 4 ทิศ” ให้เลือกแกนที่เด่นกว่า (ดีกว่าเช็ค == 0 เพราะ analog อาจไม่เป็น 0 เป๊ะ)
	if abs(direction.x) > abs(direction.y):
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	else:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN

	if new_direction == cardinal_direction:
		return false

	cardinal_direction = new_direction

	# flip เฉพาะ side (กันหน้าหรือหลังโดน flip)
	if cardinal_direction == Vector2.LEFT or cardinal_direction == Vector2.RIGHT:
		sprite.flip_h = cardinal_direction == Vector2.LEFT
		
	return true

func set_state() -> bool:
	var new_state: String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true

func update_animation() -> void:
	animation_player.play(state + "_" + anime_direction())

func anime_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
		
		
		
		
