extends Area2D

signal gold_generated

@onready var col := $GoldTriggerArea

func _ready():
    AutoClickController.auto_click.connect(_on_auto_click)

func _input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.pressed:
        gold_generated.emit()

# Support auto_click
func _on_auto_click():
    if _mouse_in_gold_area():
        gold_generated.emit()

func _mouse_in_gold_area() -> bool:
    var rect_shape = col.shape as RectangleShape2D
    if not rect_shape:
        return false
    # 取得矩形的區域，注意 RectangleShape2D.extents 是半尺寸
    var rect_pos = col.global_position - rect_shape.extents
    var rect = Rect2(rect_pos, rect_shape.extents * 2)
    # 直接用 global mouse 位置判定是否在此矩形內
    return rect.has_point(get_global_mouse_position())
