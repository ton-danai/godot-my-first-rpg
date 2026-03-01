class_name StateIdle extends State

@onready var walk : State = $"../Walk"

const  STATE_NAME : String = "idle"

func _ready() -> void:
	pass
	

## What happens when the player enters this state?
func enter() -> void:  
	player.update_animation(STATE_NAME)

## What happens when the player exits this state?
func exit() -> void: 
	pass
	

func physics(_delta: float) -> State: 
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	
	if player.set_direction():
		player.update_animation(STATE_NAME)
	return null
	
func handle_input(_event: InputEvent) -> State:
	return null
