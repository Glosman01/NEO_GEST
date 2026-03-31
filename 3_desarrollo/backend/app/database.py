from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
# ==============================
# CONFIGURACIÓN DE BASE DE DATOS
# ==============================

DATABASE_URL = "mysql+mysqlconnector://root:1234@localhost/neogest"

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

Base = declarative_base()
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()