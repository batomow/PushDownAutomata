extends "res://addons/PushDownAutomata/PDA.gd"

export (NodePath) var entity_path
export (Array, NodePath) var _global_dependencies = []
export (Array, String) var _relative_dependencies = []
export (Array, Script) var _states = []
export (String) var _entry_state_name = "Idle"
export (int, 0, 10) var state_buffer = 10

onready var entity = get_node(entity_path)

var states = {}
var past_stack = []
var current_state = null

func _ready():
	var dependencies = _global_dependencies + _relative_dependencies
	for script in _states: 
		var state = script.new()
		var state_name = get_name_from_path(script.get_path(), PASCAL_CASE)
		state._setup(self, entity)
		if entity is Control: 
			entity.connect("gui_input", self, "_gui_input")
		state.name = state_name
		states[state.name] = state

	for _dep in dependencies: 
		var dep = get_node(_dep) if _dep in _global_dependencies else entity.get_node(_dep)
		if dep is AnimationPlayer: 
			dep.connect("animation_finished", self, "_on_animation_finished")
		var dep_name = get_name_from_path(_dep, SNAKE_CASE) if _dep in _global_dependencies else snake_case(_dep)
		for state in states.values(): 
			if dep_name in state: 
				state[dep_name] = dep

	push_state(_entry_state_name)

func _input(event):
	current_state._handle_input(event)

func _gui_input(event): 
	current_state._handle_gui_input(event)

func _unhandled_input(event):
	current_state._handle_unhandled_input(event)

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

