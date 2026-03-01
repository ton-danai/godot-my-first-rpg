class_name StateWalk extends State

@export var move_speed : float = 100.0
@onready var idle : State = $"../Idle"

const  STATE_NAME : String = "walk"

func _ready() -> void:
	pass

## What happens when the player enters this state?
func enter() -> void:  
	player.update_animation(STATE_NAME)

## What happens when the player exits this state?
func exit() -> void: 
	pass

func physics(_delta: float) -> State: 
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed	
	
	if player.set_direction() :
		player.update_animation(STATE_NAME)
	return null
	
func handle_input(_event: InputEvent) -> State:
	return null
