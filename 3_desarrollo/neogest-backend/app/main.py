from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import create_engine, Column, Integer, String, Float, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
from pydantic import BaseModel
from typing import List, Optional

app = FastAPI(title="Neogest API")

# CORS for React frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Database configuration
SQLALCHEMY_DATABASE_URL = "mysql+mysqlconnector://root@localhost/neogest_finaldb"
engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Models
class User(Base):
    __tablename__ = "usuarios"
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100))
    apellido = Column(String(100))
    telefono = Column(String(20))
    celular = Column(String(20))
    direccion = Column(String(255))
    medio_pago = Column(String(50))
    email = Column(String(100), unique=True, index=True)
    password = Column(String(255))
    role = Column(String(20), default="cliente")

# Schemas
class UserCreate(BaseModel):
    nombre: str
    apellido: str
    telefono: str
    celular: str
    direccion: str
    medio_pago: str
    email: str
    password: str

class LoginRequest(BaseModel):
    email: str
    password: str

# Endpoints
@app.post("/register")
def register_user(user: UserCreate):
    db = SessionLocal()
    db_user = User(**user.dict())
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    db.close()
    return {"message": "Usuario registrado exitosamente"}

@app.post("/login")
def login(request: LoginRequest):
    # Simulated login for now, will connect to DB properly
    if request.email == "admin@neogest.com" and request.password == "admin123":
        return {"role": "admin", "token": "fake-admin-token"}
    return {"role": "cliente", "token": "fake-client-token"}

@app.get("/dashboard/stats")
def get_stats():
    return {
        "ventas": 45200,
        "pedidos_pendientes": 24,
        "stock_bajo": 5,
        "envios_transito": 18
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
