from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
import mysql.connector
import os

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.mount("/", StaticFiles(directory="app/static", html=True), name="static")

DB_CONFIG = {
    'host': os.environ.get("DB_HOST", "db"),
    'user': os.environ.get("DB_USER", "user"),
    'password': os.environ.get("DB_PASSWORD", "password"),
    'database': os.environ.get("DB_NAME", "testdb"),
}


@app.get("/api/users")
def get_users():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, name FROM users")
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result

