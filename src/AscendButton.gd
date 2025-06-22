extends Button

@export var main: Node2D
@export var ascension_data: AscensionData

var target_level :int = 30

func _ready():
    target_level = ascension_data.ascend_level_list[main.ascension_level]
    text = "達到%d層可飛昇" % target_level
    pressed.connect(_on_pressed)

func _on_pressed():
    main.try_ascend()
    target_level = ascension_data.ascend_level_list[main.ascension_level]
    text = "達到%d層可飛昇" % target_level
