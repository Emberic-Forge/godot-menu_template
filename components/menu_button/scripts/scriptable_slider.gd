class_name ScriptableSlider extends HSlider

@export var use_expression : bool = true
@export_custom(PROPERTY_HINT_EXPRESSION,"") var expression : String

@onready var expr = Expression.new()

signal on_slider_ready(slider : ScriptableSlider)

func _ready() -> void:
	on_slider_ready.emit(self)
	if use_expression:
		value_changed.connect(_execute_expression)

func _execute_expression(value: float) -> void:
	var error = expr.parse(expression, ["value"])
	assert(error == OK, "Expression Failed: %s" % expr.get_error_text())
	var result = expr.execute([value],self)
	assert(not expr.has_execute_failed(), "Expression Failed: %s" % expr.get_error_text())
