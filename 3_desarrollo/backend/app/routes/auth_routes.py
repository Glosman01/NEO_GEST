from fastapi import APIRouter, HTTPException
from app.database import SessionLocal
from app.models.usuario import Usuario
from app.schemas.usuario_schema import UsuarioRegistro, LoginRequest
from app.security.security import hash_password, verify_password

router = APIRouter()

# ==============================
# ENDPOINT: REGISTRO USUARIO
# ==============================

@router.post("/register")
def registrar_usuario(usuario: UsuarioRegistro):

    db = SessionLocal()

    usuario_existente = db.query(Usuario).filter(
        Usuario.email == usuario.email
    ).first()

    if usuario_existente:

        raise HTTPException(
            status_code=400,
            detail="El correo ya está registrado"
        )

    nuevo_usuario = Usuario(
        email=usuario.email,
        password_hash=hash_password(usuario.password),
        Rol_idRol=usuario.rol,
        estado=1
    )

    db.add(nuevo_usuario)
    db.commit()
    db.refresh(nuevo_usuario)

    return {
        "mensaje": "Usuario registrado",
        "idUsuario": nuevo_usuario.idUsuario
    }


# ==============================
# ENDPOINT: LOGIN
# ==============================

@router.post("/login")
def login(request: LoginRequest):

    db = SessionLocal()

    usuario = db.query(Usuario).filter(
        Usuario.email == request.email
    ).first()

    if not usuario:

        raise HTTPException(
            status_code=404,
            detail="Usuario no encontrado"
        )

    if not verify_password(request.password, usuario.password_hash):

        raise HTTPException(
            status_code=401,
            detail="Contraseña incorrecta"
        )

    return {
        "mensaje": "Login exitoso",
        "idUsuario": usuario.idUsuario,
        "rol": usuario.Rol_idRol
    }
