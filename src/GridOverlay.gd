extends Node2D

@export var column_count: int = 2  # 初始為2格
@export var row_height: int = 80   # 每層高度（用來畫橫線，可選）

func _ready():
    pass

func set_column_count(count: int):
    column_count = count
    queue_redraw()

func _draw():
    var viewport_height = get_viewport_rect().size.y
    var column_width = 960.0 / column_count
    var viewport_width = 960

    # 畫垂直格線
    for i in range(column_count + 1):
        var x = i * column_width
        draw_line(Vector2(x, 0), Vector2(x, viewport_height), Color(1, 1, 1, 0.2), 1)

    # 可選：畫水平格線（若你牆每層固定高）
    for y in range(0, int(viewport_height), row_height):
        draw_line(Vector2(0, y), Vector2(viewport_width, y), Color(1, 1, 1, 0.1), 1)
