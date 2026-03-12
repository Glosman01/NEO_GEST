from fastapi import APIRouter, HTTPException
from app.database import SessionLocal
from app.models.cliente import Cliente
from app.models.usuario import Usuario
from app.schemas.cliente_schema import ClienteRegistro, RegistroCliente
from app.security.security import hash_password

router = APIRouter()

@router.post("/clientes")
def crear_cliente(cliente: ClienteRegistro):

    db = SessionLocal()

    nuevo_cliente = Cliente(
        nombre_completo=cliente.nombre_completo,
        telefono=cliente.telefono,
        direccion_envio=cliente.direccion_envio,
        direccion_facturacion=cliente.direccion_facturacion,
        codigo_postal=cliente.codigo_postal,
        Usuario_idUsuario=cliente.usuario_id
    )

    db.add(nuevo_cliente)
    db.commit()

    return {"mensaje": "Cliente creado correctamente"}


@router.post("/registro-cliente")
def registro_cliente(data: RegistroCliente):

    db = SessionLocal()

    usuario_existente = db.query(Usuario).filter(
        Usuario.email == data.email
    ).first()

    if usuario_existente:
        raise HTTPException(
            status_code=400,
            detail="El correo ya está registrado"
        )

    nuevo_usuario = Usuario(
        email=data.email,
        password_hash=hash_password(data.password),
        Rol_idRol=3,
        estado=1
    )

    db.add(nuevo_usuario)
    db.commit()
    db.refresh(nuevo_usuario)

    nuevo_cliente = Cliente(
        nombre_completo=data.nombre_completo,
        telefono=data.telefono,
        direccion_envio=data.direccion_envio,
        direccion_facturacion=data.direccion_facturacion,
        codigo_postal=data.codigo_postal,
        Usuario_idUsuario=nuevo_usuario.idUsuario
    )

    db.add(nuevo_cliente)
    db.commit()

    return {
        "mensaje": "Cliente registrado correctamente",
        "idUsuario": nuevo_usuario.idUsuario
    }