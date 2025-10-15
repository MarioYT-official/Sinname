extends Node
@onready var quality_label = $"World/UI/QualityLabel"
@onready var light = $"World/DirectionalLight3D"

var current_quality = "Medio"
var qualities = ["Bajo", "Medio", "Alto", "Ultra 4K"]

func toggle_menu():
    if quality_label.visible:
        quality_label.visible = false
    else:
        quality_label.visible = true

func _process(delta):
    if quality_label.visible:
        if Input.is_action_just_pressed("ui_up"):
            _change_quality(1)
        elif Input.is_action_just_pressed("ui_down"):
            _change_quality(-1)

func _change_quality(direction):
    var index = qualities.find(current_quality)
    index = clamp(index + direction, 0, qualities.size() - 1)
    current_quality = qualities[index]
    _apply_quality(current_quality)
    quality_label.text = "Gráficos: " + current_quality

func _apply_quality(level):
    match level:
        "Bajo":
            RenderingServer.set_default_clear_color(Color(0,0,0))
            ProjectSettings.set_setting("rendering/quality/directional_shadow/size", 512)
            light.shadow_enabled = false
        "Medio":
            RenderingServer.set_default_clear_color(Color(0.1,0.1,0.1))
            ProjectSettings.set_setting("rendering/quality/directional_shadow/size", 1024)
            light.shadow_enabled = true
        "Alto":
            ProjectSettings.set_setting("rendering/quality/directional_shadow/size", 2048)
        "Ultra 4K":
            ProjectSettings.set_setting("rendering/quality/directional_shadow/size", 4096)
            Engine.set_target_fps(120)
