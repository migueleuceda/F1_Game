extends Control

var scene_to_load = "res://Escenas/pista.tscn"   # Ruta de la escena de juego

# Método que se ejecuta cuando el menú se carga
func _ready():
	# Asegurarse de que el nodo "Jugar" esté presente antes de conectar la señal
	var jugar_button = $VBoxContainer/Jugar
	jugar_button.connect("pressed", self, "_on_Jugar_pressed")

# Método que maneja el evento cuando el botón "Jugar" es presionado
func _on_Jugar_pressed():
	print("Botón Jugar presionado")  # Esto se imprime en la consola cuando el botón es presionado
	SceneManager.change_scene(scene_to_load)



func _on_Salir_pressed():
	get_tree().quit()
