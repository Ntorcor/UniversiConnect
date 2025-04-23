from flask import Flask, render_template, request, redirect, url_for, session
import psycopg2

from dotenv import load_dotenv
import os

# Load environment variables from .env
load_dotenv()

# Fetch variables
USER = os.getenv("Ntorcor")
PASSWORD = os.getenv("UniversiConnect2025")
HOST = os.getenv("UniversiConnect")
PORT = os.getenv("5432")
DBNAME = os.getenv("dbname")

# Connect to the database
try:
    connection = psycopg2.connect(
        user=USER,
        password=PASSWORD,
        host=HOST,
        port=PORT,
        dbname=DBNAME
    )
    print("Connection successful!")
    
    # Create a cursor to execute SQL queries
    cursor = connection.cursor()
    
    # Example query
    cursor.execute("SELECT NOW();")
    result = cursor.fetchone()
    print("Current Time:", result)

    # Close the cursor and connection
    cursor.close()
    connection.close()
    print("Connection closed.")

except Exception as e:
    print(f"Failed to connect: {e}")

app = Flask(__name__)
app.secret_key = "clave_secreta"  

#conexion = mysql.connector.connect(
    #host="localhost",
    #user="root",  
    #password="1234",  
    #database="PROYECTO"
#)
#cursor = conexion.cursor()

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

@app.route("/dashboard")
def dashboard():
    if "usuario" in session:
        return render_template("dashboard.html", usuario=session["usuario"])
    else:
        return redirect(url_for("login"))

# Ruta para cerrar sesión
@app.route("/logout")
def logout():
    session.pop("usuario", None)
    return redirect(url_for("login"))

# Rutas para los botones adicionales
@app.route("/pedir_tutoria")
def pedir_tutoria():
    return render_template("pedir_tutoria.html")  # Crear plantilla para pedir tutoría

@app.route("/reservar_aula")
def reservar_aula():
    return render_template("reservar_aula.html")  # Crear plantilla para reservar aula

if __name__ == "_main_":
    app.run(debug=True)
