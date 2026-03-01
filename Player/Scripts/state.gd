class_name State extends Node

var player: Player
func _ready() -> void:
	pass
	

## What happens when the player enters this state?
func enter() -> void:  
	assert(false, "enter() must be overridden")

## What happens when the player exits this state?
func exit() -> void: 
	assert(false, "exit() must be overridden")
	pass

func physics(_delta: float) -> State: 
	assert(false, "physics() must be overridden")
	return null
	
func handle_input(_event: InputEvent) -> State:
	assert(false, "_event() must be overridden")
	return null
