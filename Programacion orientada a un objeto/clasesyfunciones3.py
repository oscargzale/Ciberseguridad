class Coche:
    def __init__(self, marca, velocidad):
        self.marca = marca
        self.velocidad = velocidad

    def aumentar_velocidad(self, aumento):
        self.velocidad = self.velocidad + aumento
        print("Velocidad actual:", self.velocidad)


# Ejemplo
c = Coche("Toyota", 50)
c.aumentar_velocidad(20)
