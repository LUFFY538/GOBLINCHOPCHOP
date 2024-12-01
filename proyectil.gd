extends Area2D

@export var velocidad : float = 500  # Velocidad del proyectil
@export var tiempo_vida : float = 2.0  # Tiempo antes de que el proyectil se destruya

var tiempo_actual = 0.0

func _process(delta):
	# Mueve el proyectil hacia adelante en la dirección de su rotación
	position += Vector2(cos(rotation), sin(rotation)) * velocidad * delta

	# Cuenta el tiempo de vida 
	tiempo_actual += delta
	if tiempo_actual >= tiempo_vida:
		queue_free()  # Destruye el proyectil después de su tiempo de vida
func _on_body_entered(body):
	# Elimina el proyectil cuando colisiona con algo
	queue_free()
