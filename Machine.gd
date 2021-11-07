extends "res://addons/PushDownAutomata/PDA.gd"

export (NodePath) var entity_path
export (Array, NodePath) var _dependencies = []
export (Array, Script) var _states = []
export (String) var _entry_state_name = "Idle"
export (int, 0, 10) var state_buffer = 10

onready var entity = get_node(entity_path)

var states = {}
var past_stack = []
var current_state = null

func _ready():
	for script in _states: 
		var state = script.new()
		var state_name = get_name_from_path(script.get_path(), PASCAL_CASE)
		state._setup(self, entity)
		state.name = state_name
		states[state.name] = state

	for path in _dependencies: 
		var dep = get_node(path)
		if dep is AnimationPlayer: 
			dep.connect("animation_finished", self, "_on_animation_finished")
		var dep_name = get_name_from_path(path, SNAKE_CASE)
		if dep: 
			for state in states.values(): 
				if dep_name in state: 
					state[dep_name] = dep
		else: 
			printerr("couldn't find dependency: ", dep)

	push_state(_entry_state_name)

func _input(event):
	current_state._handle_input(event)

func _on_animation_finished(anim_name): 
	current_state._handle_animation_finished(anim_name)

func _process(delta):
	current_state._handle_process(delta)

func _physics_process(delta):
	current_state._handle_physics_process(delta)
		
func push_state(state_name, args = {}): 
	assert(state_name in states, "There is no state with name: %s" % state_name)
	var new_state = states[state_name]
	if current_state: 
		current_state._exit()
		past_stack.push_front(current_state)
		if past_stack.size() > state_buffer: 
			past_stack.pop_back()
	current_state = new_state
	current_state.set_args(args)
	current_state._enter()

func pop_state():
	assert(past_stack, "There are no more states to pop!")
	if current_state:
		current_state._exit()
	var new_state = past_stack.pop_front()
	if new_state: 
		current_state = new_state
		current_state._enter()

func print_buffer(): 
	var names = []
	for state in past_stack:
		names.push_back(state.name)
	print("<- ", current_state.name, " : ",  names)
