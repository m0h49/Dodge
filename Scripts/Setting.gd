extends CanvasLayer

# var shader = $CanvasLayer/fade.material
# shader.set_shader_param("aspect_ratio", ratio)

export var shaderpath = ""

var music = false
var sound = false
var fps = true
	

func _on_BackButton_pressed():
	$MarginContainer.hide()
	get_node("../HUD/MarginContainer").show()

func _on_MusicCheckButton_pressed():
	if music:
		get_node("../Music").stream_paused = false
		music = false
	else:
		get_node("../Music").stream_paused = true
		music = true
	
func _on_SoundCheckButton_pressed():
	if sound:
		get_node("../DeathSound").stream_paused = false
		sound = false
	else:
		get_node("../DeathSound").stream_paused = true
		sound = true

func _on_FPSButton_pressed():
	if fps:
		$FPS.show()
		fps = false
	else:
		$FPS.hide()
		fps = true
