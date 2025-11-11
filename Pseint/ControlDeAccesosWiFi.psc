ALGORITMO ControlDeAccesosWiFi
	
    // ==============================
    // VARIABLES Y ESTRUCTURAS
    // ==============================
    DEFINIR opcion, contadorDispositivos, i, j, limiteConexiones COMO ENTERO
    DEFINIR mac, ip, usuario COMO CADENA
    DIMENSION dispositivosMAC[100]
    DIMENSION dispositivosIP[100]
    DIMENSION usuarios[100]
    DIMENSION conexiones[100, 10]  // cada usuario puede tener hasta 10 dispositivos
    DIMENSION contadorConexiones[100]
	
    contadorDispositivos <- 0
    limiteConexiones <- 3   // máximo de dispositivos permitidos por usuario
	
    // ==============================
    // SUBPROCESOS
    // ==============================
	
    SUBPROCESO RegistrarDispositivo()
        ESCRIBIR "Ingrese el nombre de usuario:"
        LEER usuario
        ESCRIBIR "Ingrese la dirección MAC del dispositivo:"
        LEER mac
        ESCRIBIR "Ingrese la dirección IP del dispositivo:"
        LEER ip
		
        // Buscar si el usuario ya existe
        DEFINIR indiceUsuario COMO ENTERO
        indiceUsuario <- 0
		
        PARA i <- 1 HASTA contadorDispositivos HACER
            SI usuarios[i] = usuario ENTONCES
                indiceUsuario <- i
                SALIR PARA
				FINSI
			FINPARA
			
			// Si no existe, crear nuevo registro
			SI indiceUsuario = 0 ENTONCES
				contadorDispositivos <- contadorDispositivos + 1
				indiceUsuario <- contadorDispositivos
				usuarios[indiceUsuario] <- usuario
				contadorConexiones[indiceUsuario] <- 0
			FINSI
			
			// Registrar conexión
			contadorConexiones[indiceUsuario] <- contadorConexiones[indiceUsuario] + 1
			j <- contadorConexiones[indiceUsuario]
			conexiones[indiceUsuario, j] <- mac
			dispositivosMAC[indiceUsuario] <- mac
			dispositivosIP[indiceUsuario] <- ip
			
			ESCRIBIR "Dispositivo registrado correctamente para el usuario ", usuario
FINSUBPROCESO


SUBPROCESO ValidarAcceso()
	ESCRIBIR "Ingrese el nombre del usuario que intenta conectarse:"
	LEER usuario
	
	DEFINIR indiceUsuario COMO ENTERO
	indiceUsuario <- 0
	
	PARA i <- 1 HASTA contadorDispositivos HACER
		SI usuarios[i] = usuario ENTONCES
			indiceUsuario <- i
			SALIR PARA
            FINSI
        FINPARA
		
        SI indiceUsuario = 0 ENTONCES
            ESCRIBIR "Usuario no registrado. Acceso denegado."
            RETORNAR
        FINSI
		
        // Validar número de conexiones
        SI contadorConexiones[indiceUsuario] > limiteConexiones ENTONCES
            ESCRIBIR "ALERTA: El usuario ", usuario, " ha superado el límite de conexiones (", limiteConexiones, ")."
        SINO
            ESCRIBIR "Acceso permitido al usuario ", usuario, ". Conexiones activas: ", contadorConexiones[indiceUsuario]
        FINSI
FINSUBPROCESO


SUBPROCESO GenerarAlertas()
	DEFINIR hayAlerta COMO LOGICO
	hayAlerta <- FALSO
	
	ESCRIBIR "===== ALERTAS DE CONEXIONES ====="
	PARA i <- 1 HASTA contadorDispositivos HACER
		SI contadorConexiones[i] > limiteConexiones ENTONCES
			ESCRIBIR "ALERTA: Usuario ", usuarios[i], " con ", contadorConexiones[i], " dispositivos conectados."
			hayAlerta <- VERDADERO
		FINSI
	FINPARA
	
	SI hayAlerta = FALSO ENTONCES
		ESCRIBIR "No se encontraron accesos no autorizados."
	FINSI
FINSUBPROCESO


SUBPROCESO MostrarDispositivos()
	SI contadorDispositivos = 0 ENTONCES
		ESCRIBIR "No hay dispositivos registrados."
	SINO
		ESCRIBIR "===== LISTA DE DISPOSITIVOS ====="
		PARA i <- 1 HASTA contadorDispositivos HACER
			ESCRIBIR i, ") Usuario: ", usuarios[i]
			ESCRIBIR "   MAC: ", dispositivosMAC[i]
			ESCRIBIR "   IP: ", dispositivosIP[i]
			ESCRIBIR "   Conexiones activas: ", contadorConexiones[i]
			ESCRIBIR "-----------------------------------"
		FINPARA
	FINSI
FINSUBPROCESO


// ==============================
// MENÚ PRINCIPAL
// ==============================
opcion <- -1
MIENTRAS opcion <> 0 HACER
	ESCRIBIR ""
	ESCRIBIR "===== CONTROL DE ACCESOS WIFI ====="
	ESCRIBIR "1) Registrar dispositivo"
	ESCRIBIR "2) Validar acceso"
	ESCRIBIR "3) Generar alertas"
	ESCRIBIR "4) Mostrar dispositivos"
	ESCRIBIR "0) Salir"
	ESCRIBIR "Seleccione una opción:"
	LEER opcion
	
	SEGUN opcion HACER
		1:
			RegistrarDispositivo()
		2:
			ValidarAcceso()
		3:
			GenerarAlertas()
		4:
			MostrarDispositivos()
		0:
			ESCRIBIR "Saliendo del sistema..."
		DE OTRO MODO:
			ESCRIBIR "Opción no válida, intente nuevamente."
	FINSEGUN
FINMIENTRAS

FINALGORITMO
