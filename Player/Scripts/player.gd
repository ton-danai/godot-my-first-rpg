class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 =  Vector2.ZERO

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

func _ready() -> void:
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	state_machine.physics_tick(delta) # ให้มันเรียก curr_state.physic
	move_and_slide()

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
	else: sprite.flip_h = false
		
	return true

func update_animation(state :String) -> void:
	animation_player.play(state + "_" + anime_direction())

func anime_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
