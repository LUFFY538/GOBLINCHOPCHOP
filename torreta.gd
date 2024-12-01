extends Node2D

# Exportar la escena del proyectil para que puedas asignarla desde el Inspector
@export var proyectil_escena : PackedScene

# Tiempo entre disparos (puedes ajustarlo en el Inspector)
@export var tiempo_entre_disparos : float = 1.0

# Nodo objetivo (opcional, por si la torreta debe apuntar hacia algo)
@export var objetivo : NodePath

# Variables internas
var tiempo_actual = 0.0  # Contador para manejar el tiempo entre disparos

func _process(delta):
	# Control del temporizador para disparos automáticos
	tiempo_actual += delta
	if tiempo_actual >= tiempo_entre_disparos:
		disparar()
		tiempo_actual = 0.0

	# Apuntar hacia el objetivo si está configurado
	if has_node(objetivo):
		apuntar_hacia_objetivo()

# Función para disparar proyectiles
func disparar():
	if not proyectil_escena:
		print("Error: No se ha asignado una escena de proyectil.")
		return
	
	# Instanciar el proyectil
	var proyectil = proyectil_escena.instance()
	# Colocar el proyectil en la posición del nodo Salida
	proyectil.global_position = $Pivote_del_cañón/Cañón/Salida.global_position
	# Alinear la rotación del proyectil con la dirección del cañón
	proyectil.rotation = $Pivote_del_cañón.rotation
	# Añadir el proyectil a la escena
	get_tree().current_scene.add_child(proyectil)

# Función para apuntar hacia un objetivo
func apuntar_hacia_objetivo():
	var nodo_objetivo = get_node(objetivo)
	if nodo_objetivo:
		var direccion = (nodo_objetivo.global_position - $Pivote_del_cañón.global_position).normalized()
		$Pivote_del_cañón.rotation = direccion.angle()
