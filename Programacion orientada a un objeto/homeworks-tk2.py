import tkinter as tk

def mostrar_texto():
    texto = entrada.get()
    label_resultado.config(text=texto)

ventana = tk.Tk()
ventana.title("Ejercicio 2")

entrada = tk.Entry(ventana)
entrada.pack()

boton = tk.Button(ventana, text="Mostrar", command=mostrar_texto)
boton.pack()

label_resultado = tk.Label(ventana, text="")
label_resultado.pack()

ventana.mainloop()
