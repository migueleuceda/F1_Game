extends Node

# Ruta de las escenas
var scene_menu = "res://Escenas/menu.tscn"
var scene_game = "res://Escenas/pista.tscn"

# Cambia la escena
func change_scene(scene_path: String):
	get_tree().change_scene(scene_path)
