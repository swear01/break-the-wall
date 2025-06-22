# res://themes/ThemeGenerator.gd
@tool
extends Node

const OUTPUT_PATH := "res://themes/themes.tres"

func _ready():
    generate_color_config()
    print("✅ ColorThemeConfig generated to: ", OUTPUT_PATH)

func generate_color_config():
    var config := ColorThemeConfig.new()

    var colors := [
        {"name": "black",  "bg": Color(0, 0, 0, 1),        "hl": Color(0.8, 0.8, 0.8, 1)},
        {"name": "red",    "bg": Color(0.33, 0, 0, 1),     "hl": Color(1, 0.33, 0.33, 1)},
        {"name": "peach",  "bg": Color(0.4, 0.2, 0.2, 1),  "hl": Color(1, 0.73, 0.6, 1)},
        {"name": "orange", "bg": Color(0.4, 0.2, 0, 1),    "hl": Color(1, 0.67, 0.33, 1)},
        {"name": "yellow", "bg": Color(0.4, 0.4, 0, 1),    "hl": Color(1, 1, 0.33, 1)},
        {"name": "cyan",   "bg": Color(0, 0.33, 0.33, 1),  "hl": Color(0.33, 1, 1, 1)},
        {"name": "green",  "bg": Color(0, 0.2, 0, 1),      "hl": Color(0.33, 1, 0.33, 1)},
        {"name": "blue",   "bg": Color(0, 0, 0.33, 1),     "hl": Color(0.33, 0.33, 1, 1)},
        {"name": "purple", "bg": Color(0.2, 0, 0.2, 1),    "hl": Color(0.67, 0.33, 1, 1)},
        {"name": "white",  "bg": Color(0.87, 0.87, 0.87, 1), "hl": Color(0, 0, 0, 1)},
    ]

    for c in colors:
        var cs := ColorSet.new()
        cs.name = c.name
        cs.bg = c.bg
        cs.hl = c.hl
        config.color_sets.append(cs)

    ResourceSaver.save(config, OUTPUT_PATH, ResourceSaver.FLAG_REPLACE_SUBRESOURCE_PATHS)
