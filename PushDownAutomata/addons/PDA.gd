tool
extends Node

const SNAKE_CASE = 0
const PASCAL_CASE = 1

static func get_name_from_path(string, case=PASCAL_CASE)->String:
	if not string: 
		return ""
	var regex = RegEx.new()
	regex.compile("[A-Z]\\w+")
	var path_parts = regex.search_all(string)
	var last_part = path_parts[-1]
	if case == PASCAL_CASE:
		return last_part.get_string()
	else:
		return snake_case(last_part.get_string())

static func snake_case(string)->String: 
	if not string: 
		return ""
	var regex = RegEx.new()
	regex.compile("[A-Z]([a-z])*")
	var word_parts = regex.search_all(string)
	if not word_parts: 
		return ""
	var aux = PoolStringArray()
	for word in word_parts: 
		aux.push_back(word.get_string().to_lower())
	return aux.join("_")
