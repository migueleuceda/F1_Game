extends Area2D


var vueltas_jugador1 = 0  
var vueltas_jugador2 = 0 
var coche_dentro_meta = {}  
var meta_direccion = Vector2(0, -1)  
var cruzo_hacia_atras = {}  
var en_vuelta = {}  


func _ready():
	coche_dentro_meta["CocheJugador"] = false
	coche_dentro_meta["Cochejugador2"] = false
	cruzo_hacia_atras["CocheJugador"] = false
	cruzo_hacia_atras["Cochejugador2"] = false
	en_vuelta["CocheJugador"] = false
	en_vuelta["Cochejugador2"] = false


func _on_Meta_body_entered(body):
	if body.name in ["CocheJugador", "Cochejugador2"] and not coche_dentro_meta[body.name]:
		coche_dentro_meta[body.name] = true  
		

		if body.has_method("get_velocity"):
			var coche_velocidad = body.get_velocity()
			var coche_direccion = coche_velocidad.normalized()
			
			if coche_direccion.dot(meta_direccion) > 0: 

				if cruzo_hacia_atras[body.name]:
					print("El coche cruzó hacia atrás previamente. Vuelta no contada.")
					cruzo_hacia_atras[body.name] = false  
				elif not en_vuelta[body.name]: 
					if body.name == "CocheJugador":
						vueltas_jugador1 += 1  
						print("¡Vuelta completada por CocheJugador! Vueltas:", vueltas_jugador1)
						if vueltas_jugador1 == 4:
							print("¡CocheJugador ha ganado la carrera!")
							Global.ganador = "1"  
							print("Global.ganador:", Global.ganador) 
					elif body.name == "Cochejugador2":
						vueltas_jugador2 += 1 
						print("¡Vuelta completada por CocheJugador2! Vueltas:", vueltas_jugador2)
						if vueltas_jugador2 == 4:
							print("¡CocheJugador2 ha ganado la carrera!")
							Global.ganador = "2"  
							print("Global.ganador:", Global.ganador) 
					en_vuelta[body.name] = true  
			else:
				cruzo_hacia_atras[body.name] = true 
				print("El coche cruzó hacia atrás. Vuelta no contada.")
		else:
			print("El objeto no tiene el método 'get_velocity'. Asegúrate de implementarlo en el coche.")

func _on_Meta_body_exited(body):
	if body.name in ["CocheJugador", "Cochejugador2"]:
		coche_dentro_meta[body.name] = false  
		if cruzo_hacia_atras[body.name]:
			print("El coche salió del área de meta después de cruzar hacia atrás.")
		else:
			print("Coche salió del área de meta.")
		en_vuelta[body.name] = false 
