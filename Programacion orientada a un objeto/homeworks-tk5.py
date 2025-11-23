import tkinter as tk

def dibujar(event):
    x = event.x
    y = event.y
    canvas.create_line(x, y, x+1, y+1)  # línea muy pequeña (dibujo)

ventana = tk.Tk()
ventana.title("Ejercicio 5")

canvas = tk.Canvas(ventana, width=400, height=300, bg="white")
canvas.pack()

canvas.bind("<B1-Motion>", dibujar)  # dibuja mientras se mueve el mouse con botón presionado

ventana.mainloop()
