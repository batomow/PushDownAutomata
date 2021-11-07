extends "res://addons/PushDownAutomata/State.gd"

# %TS%Declare your dependencies here in snake case. 
#%TS%Must match its pascal case counter part from the scene tree. 

#var animation_player:AnimationPlayer

#runs once when entering the state
func _enter()%VOID_RETURN%:
#%TS%var my_var = get_arg("my_var")
%TS%pass

#Runs in the _input(event) Node function
func _handle_input(event)%VOID_RETURN%:
%TS%pass

#called when the dependency of type AnimationPlayer finished playing an animations, only if there is one. 
func _handle_animation_finished(anim_name%STRING_TYPE%)%VOID_RETURN%:
#%TS%if anim_name == "some_anim":
#%TS%%TS%push_state("NewState")
%TS%pass

#Runs in the _process(delta) 
func _handle_process(_delta%FLOAT_TYPE%)%VOID_RETURN%:
%TS%pass

#runs in the physics process(delta)
func _handle_physics_process(_delta%FLOAT_TYPE%)%VOID_RETURN%:
%TS%pass

#runs once when exiting the state, default behavior:  args = {}
func _exit()%VOID_RETURN%:
#%TS%save_args({"my_var":10})
%TS%pass

# pop_state()
#%TS%Exits the current state and sets the current state and
#%TS%sets the current state to the top of the stack.

# push_state("StateName", {"my_var", value} (optional, default = {}) ) 
#%TS%Sets the new state to "StateName" and passes arguments to the new state. 
#%TS%Pushes the current state to the top of the state stack. 

#print_buffer(): 
#%TS% Displays the current state and state stack.

#get_arg("my_var") 
#%TS%Looks for "my_var" in the args diccionary, if not found returns null

#save_args({"my_var", value} (optional, default = {}) )
#%TS%Sets the current args to {"my_var": 10}, 
#%TS%Override _exit() to prevent args from being deleted automatically.