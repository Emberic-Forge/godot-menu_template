class_name ScriptableButton extends Button

@export var use_expression : bool = true
@export_custom(PROPERTY_HINT_EXPRESSION,"") var expression : String

@onready var expr = Expression.new()

func _ready() -> void:
	if use_expression:
		button_down.connect(_execute_expression)

func _execute_expression() -> void:
	var error = expr.parse(expression)
	assert(error == OK, "Expression Failed: %s" % expr.get_error_text())
	var result = expr.execute([],self)
	assert(not expr.has_execute_failed(), "Expression Failed: %s" % expr.get_error_text())

func fully_quit() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
