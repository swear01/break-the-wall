extends Node

signal auto_click  # 所有想要接收自動點擊事件的區塊都可以連結這個

var is_pressing := false
var press_time := 0.0
var auto_click_timer := 0.0

const AUTO_CLICK_DELAY : float = 0.7
var auto_click_interval : float= 10000000.0

func _input(event):
    if event is InputEventMouseButton or event is InputEventScreenTouch:
        if event.pressed:
            is_pressing = true
            press_time = 0.0
            auto_click_timer = 0.0
        else:
            is_pressing = false
            press_time = 0.0
            auto_click_timer = 0.0

func _process(delta):
    #print(delta)
    if is_pressing:
        press_time += delta
        if press_time >= AUTO_CLICK_DELAY:
            auto_click_timer += delta
            while auto_click_timer >= auto_click_interval:
                auto_click_timer -= auto_click_interval
                emit_signal("auto_click")
