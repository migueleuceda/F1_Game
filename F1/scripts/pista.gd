extends Node2D

onready var viewport1 = $HBoxContainer/ViewportContainer1/Viewport1
onready var viewport2 = $HBoxContainer/ViewportContainer2/Viewport2
onready var camera1 = $HBoxContainer/ViewportContainer1/Viewport1/Camera2D
onready var camera2 = $HBoxContainer/ViewportContainer2/Viewport2/Camera2D2
onready var pista1 = $HBoxContainer/ViewportContainer1/Viewport1/pistaCarrera
onready var resultado_label = $Resultado
onready var menu_pausa = $MenuPausa
onready var boton_continuar = $MenuPausa/BotonContinuar

func _ready():
	viewport2.world_2d = viewport1.world_2d  
	resultado_label.visible = false 
	menu_pausa.visible = false

func _process(_delta):

	camera1.global_position = pista1.get_node("CocheJugador").global_position
	camera2.global_position = pista1.get_node("Cochejugador2").global_position

	if Global.ganador != "":
		resultado_label.text = "JUGADOR " + Global.ganador + " GANA"
		menu_pausa.visible = true
		resultado_label.visible = true
		_pause_game()
		$MenuPausa/BotonContinuar.disabled = true
		print("Ganador mostrado:", Global.ganador)

func _input(event):
	if event.is_action_pressed("pause"):  
		_toggle_pause()

func _toggle_pause():
	if not get_tree().paused:
		_pause_game()

func _pause_game():
	get_tree().paused = true
	menu_pausa.visible = true
	print("Juego pausado")

func reanudar_partido():
	get_tree().paused = false
	menu_pausa.visible = false 

func _on_BotonContinuar_pressed():
	reanudar_partido()
