extends "res://addons/PushDownAutomata/PDA.gd"

class_name State, "icon.svg"

var _machine
var entity
var _args = {}

func _setup(m, e): 
	_machine = m
	entity = e

func _enter():
	pass

func _handle_input(_event):
	pass

func _handle_unhandled_input(_event): 
	pass

func _handle_gui_input(_event): 
	pass

func _handle_animation_finished(_anim_name): 
	pass

func _handle_process(_delta): 
	pass

func _handle_physics_process(_delta): 
	pass

func _exit(): 
	_args = {}

func push_state(state_name, args = {}): 
	_machine.push_state(state_name, args)

func pop_state(): 
	_machine.pop_state()

func print_buffer(): 
	_machine.print_buffer()

func set_args(args={}): 
	_args = args

func get_arg(arg_name): 
	if arg_name in _args: 
		return _args[arg_name]
	else: 
		return null

func save_args(args = {}): 
	_args = args