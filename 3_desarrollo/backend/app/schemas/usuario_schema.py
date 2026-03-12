from pydantic import BaseModel

class UsuarioRegistro(BaseModel):

    email: str
    password: str
    rol: int


class LoginRequest(BaseModel):

    email: str
    password: str