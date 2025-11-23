import tkinter as tk
import pymysql

# ----------- CONEXIÓN A LA BASE DE DATOS ----------------

def conectar():
    return pymysql.connect(
        host="localhost",
        user="root",
        password="",   # <-- Si tu MySQL tiene clave, PONLA AQUÍ
        database="examenfinal",
        cursorclass=pymysql.cursors.Cursor
    )

# ---------------- FUNCIONES ------------------

def guardar_articulo():
    try:
        codigo = int(entry_codigo.get())
        descripcion = entry_descripcion.get()
        precio = float(entry_precio.get())
    except:
        label_resultado.config(text="Datos inválidos.")
        return

    con = conectar()
    cursor = con.cursor()
    sql = "INSERT INTO articulos (codigo, descripcion, precio) VALUES (%s, %s, %s)"
    cursor.execute(sql, (codigo, descripcion, precio))
    con.commit()
    con.close()

    label_resultado.config(text="Artículo guardado correctamente")


def buscar_articulo():
    try:
        codigo = int(entry_codigo_buscar.get())
    except:
        label_buscar_resultado.config(text="Código inválido.")
        return

    con = conectar()
    cursor = con.cursor()
    sql = "SELECT descripcion, precio FROM articulos WHERE codigo=%s"
    cursor.execute(sql, (codigo,))
    fila = cursor.fetchone()
    con.close()

    if fila:
        desc = fila[0]
        precio = fila[1]
        label_buscar_resultado.config(text=f"Desc: {desc} | Precio: {precio}")
    else:
        label_buscar_resultado.config(text="Artículo no encontrado")


def mostrar_lista():
    con = conectar()
    cursor = con.cursor()
    cursor.execute("SELECT * FROM articulos")

    lista.delete(0, tk.END)

    for fila in cursor:
        texto = f"Código: {fila[0]} | Descripción: {fila[1]} | Precio: {fila[2]}"
        lista.insert(tk.END, texto)

    con.close()


# ---------------- INTERFAZ ------------------

ventana = tk.Tk()
ventana.title("Examen Final - Programación Orientada a Objetos")

# ---- CARGA ----
tk.Label(ventana, text="Código:").pack()
entry_codigo = tk.Entry(ventana)
entry_codigo.pack()

tk.Label(ventana, text="Descripción:").pack()
entry_descripcion = tk.Entry(ventana)
entry_descripcion.pack()

tk.Label(ventana, text="Precio:").pack()
entry_precio = tk.Entry(ventana)
entry_precio.pack()

btn_guardar = tk.Button(ventana, text="Guardar Artículo", command=guardar_articulo)
btn_guardar.pack()

label_resultado = tk.Label(ventana, text="", fg="green")
label_resultado.pack()

tk.Label(ventana, text="-------------------------").pack()

# ---- BUSCAR ----
tk.Label(ventana, text="Buscar por código").pack()
entry_codigo_buscar = tk.Entry(ventana)
entry_codigo_buscar.pack()

btn_buscar = tk.Button(ventana, text="Buscar", command=buscar_articulo)
btn_buscar.pack()

label_buscar_resultado = tk.Label(ventana, text="")
label_buscar_resultado.pack()

tk.Label(ventana, text="-------------------------").pack()

# ---- LISTA ----
btn_listar = tk.Button(ventana, text="Mostrar todos", command=mostrar_lista)
btn_listar.pack()

lista = tk.Listbox(ventana, width=60)
lista.pack()

ventana.mainloop()
