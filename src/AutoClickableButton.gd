extends Button

## 自動點擊的按鈕共用邏輯

func _ready():
    AutoClickController.auto_click.connect(_on_auto_click)

func _on_auto_click():
    #print("Inside button?", _mouse_in_button())
    if _mouse_in_button():
        if !disabled:
            emit_signal("pressed")

func _mouse_in_button() -> bool:
    return get_global_rect().has_point(get_global_mouse_position())
