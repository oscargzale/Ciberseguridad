import tkinter as tk

def sumar():
    n1 = int(entry1.get())
    n2 = int(entry2.get())
    resultado = n1 + n2
    label_resultado.config(text="Resultado: " + str(resultado))

ventana = tk.Tk()
ventana.title("Calculadora Simple")

label1 = tk.Label(ventana, text="Número 1:")
label1.pack()

entry1 = tk.Entry(ventana)
entry1.pack()

label2 = tk.Label(ventana, text="Número 2:")
label2.pack()

entry2 = tk.Entry(ventana)
entry2.pack()

boton = tk.Button(ventana, text="Sumar", command=sumar)
boton.pack()

label_resultado = tk.Label(ventana, text="")
label_resultado.pack()

ventana.mainloop()
