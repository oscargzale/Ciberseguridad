import tkinter as tk

def agregar():
    item = entrada.get()
    if item != "":
        lista.insert(tk.END, item)
        entrada.delete(0, tk.END)

ventana = tk.Tk()
ventana.title("Ejercicio 4")

lista = tk.Listbox(ventana)
lista.pack()

entrada = tk.Entry(ventana)
entrada.pack()

boton = tk.Button(ventana, text="Agregar", command=agregar)
boton.pack()

ventana.mainloop()
