extends VBoxContainer

@onready var info_template := $Info
@onready var error_template := $Error

# Adiciona mensagem de erro
func add_error(message: String):
	var label : Label = error_template.duplicate()
	label.text = message
	label.visible = true
	
	self.add_child(label)
	
# Adiciona mensagem de info
func add_info(message: String):
	var label : Label = info_template.duplicate()
	label.text = message
	label.visible = true
	
	self.add_child(label)

# Limpa as mensagens da tela
func _on_clear_pressed() -> void:
	var children := self.get_children()
	
	for child in children:
		if child != info_template && child != error_template:
			child.queue_free()
