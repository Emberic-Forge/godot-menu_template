class_name OpenMenuButton extends Button

@export var menu_to_open : PackedScene

func _ready() -> void:
	button_down.connect(_open_menu)


func _open_menu() -> void:
	var ins = menu_to_open.instantiate()
	add_child(ins)
