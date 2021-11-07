tool
extends EditorPlugin

func _enter_tree():
    ProjectSettings.set('editor/script_templates_search_path', "res://addons/PushDownAutomata/templates/")
    add_custom_type("Machine", "Node", preload("Machine.gd"), preload("icon.svg"))

func _exit_tree():
    remove_custom_type("Machine")