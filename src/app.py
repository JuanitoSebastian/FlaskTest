from flask import Flask
from flask import render_template
import os

app = Flask(__name__)

@app.route("/")
def index():
     return render_template("index.html")

port = os.environ.get("PORT", 5000)

if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=port)