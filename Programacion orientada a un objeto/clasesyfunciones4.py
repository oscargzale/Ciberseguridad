class CuentaBancaria:
    def __init__(self, titular, balance):
        self.titular = titular
        self.balance = balance

    def depositar(self, monto):
        self.balance = self.balance + monto
        print("Balance luego del depósito:", self.balance)

    def retirar(self, monto):
        if monto <= self.balance:
            self.balance = self.balance - monto
            print("Balance luego del retiro:", self.balance)
        else:
            print("No hay suficiente dinero.")


# Ejemplo
cuenta = CuentaBancaria("Oscar", 100)
cuenta.depositar(50)
cuenta.retirar(30)
cuenta.retirar(200)
