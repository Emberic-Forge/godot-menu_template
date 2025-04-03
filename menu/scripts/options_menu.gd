class_name OptionsMenu extends CanvasLayer

@onready var back : Button = $order/bottom/back

func _ready() -> void:
	back.button_down.connect(func(): visible = false)
	visible = false
