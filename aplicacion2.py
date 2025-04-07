from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector

app = Flask(__name__)
app.secret_key = "clave_secreta"  # Para manejar sesiones

import mysql.connector

# Conectar a la base de datos
connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="1234",
    database="PROYECTO",
    port=3306
)
if connection.is_connected():
    print("Conectado a la base de datos MySQL")

import os
SQLALCHEMY_DATABASE_URI = os.getenv('JAWSDB_URL')
print("URL de conexión:", SQLALCHEMY_DATABASE_URI)


cursor = connection.cursor()

# Ruta principal (Login)
@app.route("/", methods=["GET", "POST"])
def login():
    mensaje = ""
    if request.method == "POST":
        user_type = request.form["user_type"]
        user_id = request.form["user_id"]
        password = request.form["password"]

        # Seleccionar tabla según tipo de usuario
        if user_type == "alumno":
            tabla = "ALUMNOS"
            id_col = "NUMMATRICULA"
            pass_col = "CONTRASEÑA"
        elif user_type == "profesor":
            tabla = "PROFESOR"
            id_col = "IDPROFESOR"
            pass_col = "CONTRASEÑA"
        elif user_type == "admin":
            tabla = "ADMINISTRADORES"
            id_col = "IDADMIN"
            pass_col = "CONTRASEÑA"
        else:
            mensaje = "Tipo de usuario no válido."
            return render_template("login.html", mensaje=mensaje)

        # Verificar credenciales
        query = f"SELECT * FROM {tabla} WHERE {id_col} = %s AND {pass_col} = %s"
        cursor.execute(query, (user_id, password))
        resultado = cursor.fetchone()

        if resultado:
            session["usuario"] = user_id
            return redirect(url_for("dashboard"))  # Redirigir al dashboard
        else:
            mensaje = "ID o contraseña incorrectos."

    return render_template("login.html", mensaje=mensaje)

# Ruta del Dashboard (Página tras iniciar sesión)
@app.route("/login")
def login():
    if "usuario" in session:
        return render_template("login.html", usuario=session["usuario"])
    else:
        return redirect(url_for("login"))

# Ruta para cerrar sesión
@app.route("/logout")
def logout():
    session.pop("usuario", None)
    return redirect(url_for("login"))

if __name__ == "__main__":
    app.run(debug=True)
