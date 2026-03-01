class_name PlayerStateMachine extends Node

var states : Array[State]
var prev_state : State
var curr_state : State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(curr_state.handle_input(event))

func init(player: Player) -> void:
	states = []
	
	for c in get_children():
		if c is State:
			c.player = player
			states.append(c)
			
	if states.size() > 0 :
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state : State) -> void : 
	if new_state == null || new_state == curr_state:
		return
	
	if curr_state:
		curr_state.exit()
	
	prev_state = curr_state
	curr_state = new_state
	curr_state.enter()

func physics_tick(delta: float) -> void:
	change_state(curr_state.physics(delta))
