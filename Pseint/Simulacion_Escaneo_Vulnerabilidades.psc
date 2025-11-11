ALGORITMO SimulacionEscaneoVulnerabilidades
	
    // ==============================
    // VARIABLES Y ESTRUCTURAS
    // ==============================
    DEFINIR opcion, contadorHosts, i, j, k, contadorIntentos, contadorVuln COMO ENTERO
    DIMENSION hosts[100]
    // Para cada host guardaremos hasta 10 servicios: nombre y puerto
    DIMENSION servicioNombre[100,10]
    DIMENSION servicioPuerto[100,10]
    DIMENSION serviciosCount[100]        // número de servicios por host
	
    // Registros de intentos de escaneo
    DIMENSION intentoHost[200]
    DIMENSION intentoTipo[200]
    DIMENSION intentoOrigen[200]
    contadorIntentos <- 0
	
    // Vulnerabilidades detectadas
    DIMENSION vulnHost[200]
    DIMENSION vulnServicio[200]
    DIMENSION vulnPuerto[200]
    DIMENSION vulnRiesgo[200]
    contadorVuln <- 0
	
    contadorHosts <- 0
	
    // ==============================
    // SUBPROCESOS
    // ==============================
	
    SUBPROCESO RegistrarHost()
        DEFINIR h COMO CADENA
        ESCRIBIR "Ingrese la IP del host a registrar:"
        LEER h
		
        // Verificar si ya existe
        PARA i <- 1 HASTA contadorHosts HACER
            SI hosts[i] = h ENTONCES
                ESCRIBIR "Host ya registrado."
                RETORNAR
            FINSI
        FINPARA
		
        contadorHosts <- contadorHosts + 1
        hosts[contadorHosts] <- h
        serviciosCount[contadorHosts] <- 0
        ESCRIBIR "Host registrado: ", h
FINSUBPROCESO


SUBPROCESO AgregarServicio()
	DEFINIR h, nombreServ COMO CADENA
	DEFINIR puertoServ, idx COMO ENTERO
	
	ESCRIBIR "Host (IP) al que agregar servicio:"
	LEER h
	
	// Buscar host
	idx <- 0
	PARA i <- 1 HASTA contadorHosts HACER
		SI hosts[i] = h ENTONCES
			idx <- i
			SALIR PARA
            FINSI
        FINPARA
		
        SI idx = 0 ENTONCES
            ESCRIBIR "Host no encontrado. Registre primero el host."
            RETORNAR
        FINSI
		
        ESCRIBIR "Nombre del servicio (ej: http, ssh, mysql):"
        LEER nombreServ
        ESCRIBIR "Puerto del servicio (numero):"
        LEER puertoServ
		
        // Agregar servicio al host
        serviciosCount[idx] <- serviciosCount[idx] + 1
        j <- serviciosCount[idx]
        servicioNombre[idx,j] <- nombreServ
        servicioPuerto[idx,j] <- puertoServ
		
        ESCRIBIR "Servicio agregado a ", hosts[idx], ": ", nombreServ, ":", puertoServ
FINSUBPROCESO


SUBPROCESO RegistrarIntentoScan()
	DEFINIR h, tipo, origen COMO CADENA
	ESCRIBIR "Host (IP objetivo) del intento:"
	LEER h
	ESCRIBIR "Tipo de scan (ej: tcp-scan, udp-scan):"
	LEER tipo
	ESCRIBIR "IP origen del intento (opcional - si deja vacio se registra 'unknown'):"
	LEER origen
	SI origen = "" ENTONCES
		origen <- "unknown"
	FINSI
	
	contadorIntentos <- contadorIntentos + 1
	intentoHost[contadorIntentos] <- h
	intentoTipo[contadorIntentos] <- tipo
	intentoOrigen[contadorIntentos] <- origen
	
	ESCRIBIR "Intento registrado: ", h, " tipo=", tipo, " origen=", origen
FINSUBPROCESO


SUBPROCESO AnalizarVulnerabilidades()
	// Analiza todos los hosts y servicios y llena la lista de vulnerabilidades (heurística simple)
	DEFINIR riesgo COMO REAL
	contadorVuln <- 0
	
	SI contadorHosts = 0 ENTONCES
		ESCRIBIR "No hay hosts registrados."
		RETORNAR
	FINSI
	
	PARA i <- 1 HASTA contadorHosts HACER
		// Para cada servicio del host
		PARA j <- 1 HASTA serviciosCount[i] HACER
			// Heurística de riesgo simple:
			// - Si puerto es uno típico y servicio antiguo -> riesgo medio-alto.
			// No tenemos versiones, así que usamos puerto como indicador.
			riesgo <- 1.0
			SI servicioNombre[i,j] = "http" O servicioNombre[i,j] = "https" ENTONCES
				riesgo <- riesgo + 2.0
			FINSi
			SI servicioNombre[i,j] = "ssh" ENTONCES
				riesgo <- riesgo + 1.5
			FINSi
			SI servicioNombre[i,j] = "mysql" O servicioNombre[i,j] = "postgres" ENTONCES
				riesgo <- riesgo + 3.0
			FINSi
			// Puertos no estandar aumentan ligeramente
			SI servicioPuerto[i,j] <> 80 Y servicioPuerto[i,j] <> 443 Y servicioPuerto[i,j] <> 22 ENTONCES
				riesgo <- riesgo + 0.7
			FINSi
			
			// Normalizar riesgo a 0..10 (aquí max simple)
			SI riesgo > 10 ENTONCES
				riesgo <- 10
			FINSi
			
			// Guardar vulnerabilidad si riesgo >= 2.0 (umbral)
			SI riesgo >= 2.0 ENTONCES
				contadorVuln <- contadorVuln + 1
				vulnHost[contadorVuln] <- hosts[i]
				vulnServicio[contadorVuln] <- servicioNombre[i,j]
				vulnPuerto[contadorVuln] <- servicioPuerto[i,j]
				vulnRiesgo[contadorVuln] <- riesgo
			FINSi
		FINPARA
	FINPARA
	
	SI contadorVuln = 0 ENTONCES
		ESCRIBIR "Analisis completo: no se detectaron vulnerabilidades significativas."
	SINO
		ESCRIBIR "Analisis completo: se detectaron ", contadorVuln, " posibles vulnerabilidades."
	FINSI
FINSUBPROCESO


SUBPROCESO MostrarReporte()
	// Mostrar hosts y servicios
	SI contadorHosts = 0 ENTONCES
		ESCRIBIR "No hay hosts registrados."
	SINO
		ESCRIBIR "===== HOSTS Y SERVICIOS ====="
		PARA i <- 1 HASTA contadorHosts HACER
			ESCRIBIR "Host: ", hosts[i]
			SI serviciosCount[i] = 0 ENTONCES
				ESCRIBIR "   (sin servicios registrados)"
			SINO
				PARA j <- 1 HASTA serviciosCount[i] HACER
					ESCRIBIR "   - ", servicioNombre[i,j], " : ", servicioPuerto[i,j]
				FINPARA
			FINSI
		FINPARA
	FINSI
	
	// Mostrar vulnerabilidades encontradas
	ESCRIBIR ""
	ESCRIBIR "===== VULNERABILIDADES DETECTADAS ====="
	SI contadorVuln = 0 ENTONCES
		ESCRIBIR "No se han detectado vulnerabilidades."
	SINO
		PARA k <- 1 HASTA contadorVuln HACER
			ESCRIBIR k, ") Host: ", vulnHost[k], " - Servicio: ", vulnServicio[k], " - Puerto: ", vulnPuerto[k], " - Riesgo: ", vulnRiesgo[k]
		FINPARA
	FINSI
FINSUBPROCESO


SUBPROCESO GenerarAlertas()
	// Alertas basadas en riesgo alto y orígenes con muchos intentos
	DEFINIR i, conteo COMO ENTERO
	DEFINIR origenActual COMO CADENA
	
	// 1) Riesgo alto
	SI contadorVuln = 0 ENTONCES
		ESCRIBIR "No hay vulnerabilidades para generar alertas."
	SINO
		PARA i <- 1 HASTA contadorVuln HACER
			SI vulnRiesgo[i] >= 7.0 ENTONCES
				ESCRIBIR "ALERTA ALTA: ", vulnHost[i], " - ", vulnServicio[i], " (riesgo=", vulnRiesgo[i], ")"
			FINSi
		FINPARA
	FINSI
	
	// 2) Origenes con muchos intentos (umbral 5)
	SI contadorIntentos = 0 ENTONCES
		ESCRIBIR "No hay intentos de escaneo registrados."
	SINO
		// contar intentos por origen
		PARA i <- 1 HASTA contadorIntentos HACER
			origenActual <- intentoOrigen[i]
			conteo <- 0
			PARA j <- 1 HASTA contadorIntentos HACER
				SI intentoOrigen[j] = origenActual ENTONCES
					conteo <- conteo + 1
				FINSi
			FINPARA
			SI conteo >= 5 ENTONCES
				ESCRIBIR "ALERTA: Origen ", origenActual, " realizó ", conteo, " intentos de escaneo."
			FINSi
			// evitar duplicados: marcar origenActual como vacío para no repetir alerta
			PARA k <- 1 HASTA contadorIntentos HACER
				SI intentoOrigen[k] = origenActual ENTONCES
					intentoOrigen[k] <- ""
				FINSi
			FINPARA
		FINPARA
	FINSI
FINSUBPROCESO


// ==============================
// MENÚ PRINCIPAL
// ==============================
opcion <- -1

MIENTRAS opcion <> 0 HACER
	ESCRIBIR ""
	ESCRIBIR "===== SIMULACION DE ESCANEO DE VULNERABILIDADES ====="
	ESCRIBIR "1) Registrar host"
	ESCRIBIR "2) Agregar servicio a host"
	ESCRIBIR "3) Registrar intento de escaneo"
	ESCRIBIR "4) Analizar vulnerabilidades (todos los hosts)"
	ESCRIBIR "5) Mostrar reporte"
	ESCRIBIR "6) Generar alertas"
	ESCRIBIR "0) Salir"
	ESCRIBIR "Seleccione una opcion:"
	LEER opcion
	
	SEGUN opcion HACER
		1:
			RegistrarHost()
		2:
			AgregarServicio()
		3:
			RegistrarIntentoScan()
		4:
			AnalizarVulnerabilidades()
		5:
			MostrarReporte()
		6:
			GenerarAlertas()
		0:
			ESCRIBIR "Saliendo..."
		DE OTRO MODO:
			ESCRIBIR "Opcion no valida."
	FINSEGUN
FINMIENTRAS

FINALGORITMO
