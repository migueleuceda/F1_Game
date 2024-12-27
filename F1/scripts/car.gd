extends KinematicBody2D


var velocidad_maxima = 600
var aceleracion = 500
var freno = 600
var giro_fuerza_normal = 7 
var giro_fuerza_rapido = 10 
var direccion = Vector2(0, -1)  


var velocidad = Vector2()
var angulo_vehiculo = 0


var input_adelante = false
var input_atras = false
var input_giro = 0  

func _ready():
	
	direccion = Vector2(-1, 0)  
	
func get_velocity():
	return velocidad

func _process(delta):
	
	input_adelante = Input.is_action_pressed("p1_up")
	input_atras = Input.is_action_pressed("p1_down")
	input_giro = 0
	if Input.is_action_pressed("p1_left"):
		input_giro = -10
	if Input.is_action_pressed("p1_right"):
		input_giro = 10

	
	manejar_fisica(delta)

func manejar_fisica(delta):

	if input_adelante:
		velocidad = velocidad.move_toward(direccion * velocidad_maxima, aceleracion * delta)
	elif input_atras:
		velocidad = velocidad.move_toward(direccion * -velocidad_maxima, aceleracion * delta)
	else:
		
		velocidad = velocidad.move_toward(Vector2.ZERO, freno * delta)

	
	var giro_fuerza = giro_fuerza_normal 
	if input_giro != 0:
		giro_fuerza = giro_fuerza_rapido 

	if input_giro != 0:

		angulo_vehiculo += giro_fuerza * input_giro * delta

		angulo_vehiculo = fmod(angulo_vehiculo, 360)


	rotation = deg2rad(angulo_vehiculo)

	direccion = Vector2(0, -1).rotated(rotation)


	move_and_slide(velocidad)

	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision:
			velocidad = velocidad.bounce(collision.normal)
			break 
