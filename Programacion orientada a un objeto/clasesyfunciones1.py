class Usuario:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad

    def mostrar_datos(self):
        print("Nombre:", self.nombre, "- Edad:", self.edad)


# Ejemplo
u = Usuario("Oscar", 30)
u.mostrar_datos()
