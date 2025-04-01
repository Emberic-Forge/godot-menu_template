class_name LoadSceneButton extends Button

@export_file var scene_to_load : String
@export var multi_thread_loading : bool = false

var progress = []
var status : ResourceLoader.ThreadLoadStatus

func _ready() -> void:
	button_down.connect(_load_scene)

func _load_scene() -> void:
	ResourceLoader.load_threaded_request(scene_to_load, "", multi_thread_loading)

func _process(delta : float) -> void:
	status = ResourceLoader.load_threaded_get_status(scene_to_load, progress)
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var packed_scene = ResourceLoader.load_threaded_get(scene_to_load)
		get_tree().change_scene_to_packed(packed_scene)
		status = ResourceLoader.THREAD_LOAD_INVALID_RESOURCE
