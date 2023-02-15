from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

@app.route('/')
def index():
    return "Index Page"

@app.route('/about')
def about():
    return "<h1> The About Page</h1>"

@app.route('/user')
def user():
    return "User page"

if __name__ == "__main__":
   app.run(host="0.0.0.0")