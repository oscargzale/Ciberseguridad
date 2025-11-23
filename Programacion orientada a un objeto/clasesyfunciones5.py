class Estudiante:
    def __init__(self, nombre, calificaciones):
        self.nombre = nombre
        self.calificaciones = calificaciones

    def calcular_promedio(self):
        if len(self.calificaciones) == 0:
            return 0
        else:
            suma = sum(self.calificaciones)
            promedio = suma / len(self.calificaciones)
            return promedio


# Prueba
e1 = Estudiante("Luis", [7, 8, 9])
print("Promedio de", e1.nombre, "es:", e1.calcular_promedio())

e2 = Estudiante("Ana", [])
print("Promedio de", e2.nombre, "es:", e2.calcular_promedio())

if __name__ == "__main__":
    e1 = Estudiante("Luis", [7, 8.5, "9", "x"])
    print(e1)                 # muestra promedio considerando solo números
    e2 = Estudiante("Ana", [])
    print(e2)                 # muestra 0.00 para lista vacía