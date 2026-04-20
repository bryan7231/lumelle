extends LuaCodeEdit

func _gui_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
			await text_changed
			_handle_auto_indent()

func _handle_auto_indent():
	# Get the text of the line the user was just on
	var current_line_index = get_caret_line()
	var previous_line_text = get_line(current_line_index - 1).strip_edges()
	
	print(previous_line_text)
	
	# Keywords that usually mean the NEXT line needs an extra tab in Lua
	var indent_keywords = ["then", "do", "function", "repeat", "{"]
	
	for keyword in indent_keywords:
		if previous_line_text.ends_with(keyword) or previous_line_text.begins_with(keyword):
			# Add a tab to the current line automatically
			insert_text_at_caret("\t")
			break
