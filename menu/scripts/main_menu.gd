extends CanvasLayer

@export_file var gameplay_scene_to_load_on_play : String
@export var load_check_refresh_rate : float
@export var options_menu : PackedScene
@export var loading_screen : PackedScene

@onready var play : Button = $order/play
@onready var options : Button = $order/options
@onready var quit : Button = $order/quit

var options_ins : OptionsMenu

func _ready() -> void:
	# Get the current os name
	var os_name := OS.get_name()

	# Connect events
	play.button_down.connect(_start_game)
	options.button_down.connect(_open_options)
	# If the os is web-based, hide the quit button
	if os_name != "Web":
		quit.button_down.connect(_exit_game)
	else:
		quit.visible = false

	# Initialize options menu
	options_ins = options_menu.instantiate()
	add_child(options_ins)


func _start_game() -> void:
	LoadingSystem.load_scene(gameplay_scene_to_load_on_play)

func _open_options() -> void:
	options_ins.visible = true

func _exit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
