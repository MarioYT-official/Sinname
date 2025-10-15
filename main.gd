extends CharacterBody3D

var speed = 6.0
var camera_3rd_person = true
@onready var camera = $Camera3D
@onready var gun_sound = $GunSound
@onready var step_sound = $StepSound
@onready var graphics = get_node("/root/GraphicsManager")

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
    if Input.is_action_just_pressed("toggle_view"):
        camera_3rd_person = !camera_3rd_person
        _update_camera_view()
    if Input.is_action_just_pressed("shoot"):
        _shoot()
    if Input.is_action_just_pressed("open_menu"):
        graphics.toggle_menu()

func _physics_process(delta):
    var input_dir = Vector2(
        Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
        Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    )
    var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    velocity.x = direction.x * speed
    velocity.z = direction.z * speed
    move_and_slide()
    if direction.length() > 0 and not step_sound.playing:
        step_sound.play()

func _shoot():
    gun_sound.play()

func _update_camera_view():
    if camera_3rd_person:
        camera.translation = Vector3(0, 1.8, -4)
    else:
        camera.translation = Vector3(0, 1.7, 0.1)
