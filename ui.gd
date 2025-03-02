extends Control

@onready var editor := $HSplitContainer/Panel/MarginContainer/VBoxContainer/CodeEditor/TextEdit
@onready var lua_console := $HSplitContainer/Container/LuaConsole
@onready var icon := $HSplitContainer/Icon

@onready var log_box := $HSplitContainer/Panel/MarginContainer/VBoxContainer/MessagesContainer

func _ready() -> void:
	# "bind_method" faz com que a extensão reporte quando esses métodos
	# são chamados no script lua
	lua_console.bind_method("up")
	lua_console.bind_method("down")
	lua_console.bind_method("left")
	lua_console.bind_method("right")
	
	# conecta os sinais
	lua_console.error.connect(error_callback)
	lua_console.print.connect(print_callback)
	lua_console.called_method.connect(method_called_callback)

func print_callback(message):
	log_box.add_info(message)
	
func error_callback(message):
	log_box.add_error(message)

func method_called_callback(method_name):
	var target_position := Vector2.ZERO

	match (method_name):
		"up":
			target_position.y -= 1
		"down":
			target_position.y += 1
		"left":
			target_position.x -= 1
		"right":
			target_position.x += 1

	var tween := get_tree().create_tween()

	tween.tween_property(
		icon,
		"position",
		icon.position + target_position * 50,
		0.5)

func _on_run_button_pressed() -> void:
	var lua_source = editor.text
	
	lua_console.run_script(lua_source)
