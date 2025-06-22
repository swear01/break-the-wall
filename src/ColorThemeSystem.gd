extends Node

signal theme_changed

var color_sets: Array[ColorSet] = []
var current_color_index: int = -1
var current_color_set: ColorSet = null
var zh_font = preload("res://fonts/NotoSansMonoCJKtc-VF.otf")

func _ready():
    var config: ColorThemeConfig = load("res://themes/themes.tres")
    color_sets = config.color_sets

func get_color_set_by_layer(layer: int) -> ColorSet:
    return color_sets[layer % color_sets.size()]

func update_theme_by_layer(layer: int):
    current_color_index = int(floor(layer/5.0)) % color_sets.size()
    var color_set := get_color_set_by_layer(current_color_index)
    set_color_set(color_set)

func set_color_set(color_set: ColorSet):
    current_color_set = color_set
    theme_changed.emit()

    var bg: Color = color_set.bg
    var hl: Color = color_set.hl

    # Create a theme on-the-fly
    var theme := Theme.new()
    
    theme.set_font("font", "Label", zh_font)
    theme.set_font("font", "Button", zh_font)

    var button_style := StyleBoxFlat.new()
    button_style.bg_color = bg
    button_style.border_color = hl
    button_style.set_border_width_all(2)
    theme.set_stylebox("normal", "Button", button_style)

    # Button text color = 背景色
    theme.set_color("font_color", "Button", hl)

    # Label or general text = 高亮色
    theme.set_color("font_color", "Label", hl)

    # 套用給 Control 或非 Control
    for node in get_tree().get_nodes_in_group("theme_receivers"):
        if node is Control:
            node.theme = theme
        else:
            node.apply_theme_color(bg, hl)
