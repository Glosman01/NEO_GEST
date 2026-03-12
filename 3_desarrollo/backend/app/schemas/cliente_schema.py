from pydantic import BaseModel

class ClienteRegistro(BaseModel):
    nombre_completo: str
    telefono: str
    direccion_envio: str
    direccion_facturacion: str
    codigo_postal: str
    usuario_id: int


class RegistroCliente(BaseModel):
    email: str
    password: str
    nombre_completo: str
    telefono: str
    direccion_envio: str
    direccion_facturacion: str
    codigo_postal: str