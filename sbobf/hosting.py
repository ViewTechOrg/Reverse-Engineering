"""
ini adalah uji penggunaan yang saya buat agar bisa
menggunakan / menjalankan program dari https://github.com/kevinmel2000/sbobf/
dengan menjalankan nya ke server local (localhost)
di bangun menggunakan flask

note by polygon
"""

from flask import Flask, render_template
import os

# definisikan aplikasi dari flask
app = Flask(__name__)

# membangun rute serta merender index nya menggunakan render_template
@app.route("/")
def home():
    return(render_template("index.html"))


if __name__ == '__main__':
    app.run(debug=True, port=os.getenv("PORT", default=5000)) # berjalan pada port 5000 secara default
