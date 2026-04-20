extends Control

@onready var splitCont = $HSplitContainer
@onready var textEdit = $HSplitContainer/FoldableContainer/LuaCodeEdit

@export var default_size = 0.4
@export var font_size = 32
@export var font_scale = 8

func update_font_size(size: int) -> void:
	font_size = size
	textEdit.add_theme_font_size_override("font_size", font_size)

func _ready() -> void:
	splitCont.split_offsets[0] = get_window().size.x * default_size
	update_font_size(font_size)

func _gui_input(event: InputEvent) -> void:
	if textEdit.has_focus():
		if Input.is_action_just_pressed("increase_size"):
			update_font_size(font_size + font_scale)
		if Input.is_action_just_pressed("decrease_size"):
			update_font_size(font_size - font_scale)
	
		
