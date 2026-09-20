from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return """
    <h1>Hello from KIET Flask CI/CD</h1>
    <h2>Version 3</h2>
    <p>Deployed using AWS CodePipeline</p>
    """

@app.route("/health")
def health():
    return "Flask application is healthy"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)