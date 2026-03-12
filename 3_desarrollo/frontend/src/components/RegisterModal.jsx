// Importación de React y el Hook useState
// useState permite manejar estados dentro del componente
import React, { useState } from 'react'

/*
========================================================
COMPONENTE REGISTER MODAL
========================================================
Este componente representa una ventana modal que permite
registrar nuevos usuarios en el sistema NeoGest.

El proceso de registro se realiza en DOS pasos:

1️⃣ Crear usuario en la tabla "usuario"
ENDPOINT:
POST http://localhost:8000/register

2️⃣ Crear cliente en la tabla "cliente"
ENDPOINT:
POST http://localhost:8000/clientes

PROPS QUE RECIBE:
onClose → función que cierra la ventana modal
*/

const RegisterModal = ({ onClose }) => {

    /*
    ========================================================
    ESTADO DEL FORMULARIO
    ========================================================
    formData almacena todos los datos del cliente que
    se registrará en el sistema.
    */

    const [formData, setFormData] = useState({

        nombre_completo: '',
        telefono: '',
        direccion_envio: '',
        direccion_facturacion: '',
        codigo_postal: '',
        email: '',
        password: ''

    })

    /*
    ========================================================
    VALIDACIÓN DEL FORMULARIO
    ========================================================
    Esta función valida los datos ingresados antes de
    enviarlos al backend.
    */

    const validarFormulario = () => {

        // Validar nombre
        if (formData.nombre_completo.length < 3) {
            alert("El nombre debe tener mínimo 3 caracteres")
            return false
        }

        // Validar teléfono (solo números)
        if (!/^[0-9]+$/.test(formData.telefono)) {
            alert("El teléfono solo debe contener números")
            return false
        }

        // Validar correo
        if (!formData.email.includes("@")) {
            alert("Correo electrónico inválido")
            return false
        }

        // Validar contraseña
        if (formData.password.length < 6) {
            alert("La contraseña debe tener mínimo 6 caracteres")
            return false
        }

        return true
    }

    /*
    ========================================================
    FUNCIÓN DE ENVÍO DEL FORMULARIO
    ========================================================
    handleSubmit se ejecuta cuando el usuario presiona
    el botón "Registrarse".

    Proceso:
    1️⃣ Validar datos
    2️⃣ Crear usuario
    3️⃣ Crear cliente
    */

    const handleSubmit = async (e) => {

        // Evita que el formulario recargue la página
        e.preventDefault()

        // Validar formulario
        if (!validarFormulario()) return

        try {

            /*
            ========================================================
            PASO 1 → CREAR USUARIO
            ========================================================
            */

            const responseUser = await fetch('http://localhost:8000/register', {

                method: 'POST',

                headers: {
                    'Content-Type': 'application/json'
                },

                body: JSON.stringify({

                    email: formData.email,
                    password: formData.password,
                    rol: 3 // Rol cliente

                })

            })

            const userData = await responseUser.json()

            /*
            ========================================================
            PASO 2 → CREAR CLIENTE
            ========================================================
            */

            await fetch('http://localhost:8000/clientes', {

                method: 'POST',

                headers: {
                    'Content-Type': 'application/json'
                },

                body: JSON.stringify({

                    nombre_completo: formData.nombre_completo,
                    telefono: formData.telefono,
                    direccion_envio: formData.direccion_envio,
                    direccion_facturacion: formData.direccion_facturacion,
                    codigo_postal: formData.codigo_postal,
                    usuario_id: userData.idUsuario

                })

            })

            // Registro exitoso
            alert("Registro exitoso")

            // Cerrar modal
            onClose()

        } catch (error) {

            console.error("Error:", error)
            alert("Error en el registro")

        }

    }

    /*
    ========================================================
    RENDER DEL MODAL
    ========================================================
    */

    return (

        // CONTENEDOR OSCURECIDO DE FONDO
        <div style={{

            position: 'fixed',
            top: 0,
            left: 0,
            width: '100%',
            height: '100%',
            backgroundColor: 'rgba(15, 23, 42, 0.4)',
            backdropFilter: 'blur(5px)',
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            zIndex: 1000

        }}>

            {/* TARJETA DEL FORMULARIO */}
            <div
                className="auth-card"
                style={{
                    padding: '2.5rem',
                    maxWidth: '440px'
                }}
            >

                {/* TÍTULO */}
                <h2 style={{
                    fontSize: '1.75rem',
                    fontWeight: 700,
                    marginBottom: '2rem',
                    textAlign: 'left',
                    color: '#111827'
                }}>
                    Registrarse en Neogest
                </h2>

                {/* FORMULARIO */}
                <form onSubmit={handleSubmit}>

                    {/* CONTENEDOR DE INPUTS */}
                    <div style={{
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '0.75rem'
                    }}>

                        {/* NOMBRE COMPLETO */}
                        <input
                            className="auth-input"
                            type="text"
                            placeholder="Nombre completo"
                            required
                            onChange={e =>
                                setFormData({
                                    ...formData,
                                    nombre_completo: e.target.value
                                })
                            }
                        />

                        {/* TELÉFONO */}
                        <input
                            className="auth-input"
                            type="text"
                            placeholder="Teléfono"
                            required
                            onChange={e =>
                                setFormData({
                                    ...formData,
                                    telefono: e.target.value
                                })
                            }
                        />

                        {/* DIRECCIÓN DE ENVÍO */}
                        <input
                            className="auth-input"
                            type="text"
                            placeholder="Dirección de envío"
                            required
                            onChange={e =>
                                setFormData({
                                    ...formData,
                                    direccion_envio: e.target.value
                                })
                            }
                        />

                        {/* DIRECCIÓN DE FACTURACIÓN */}
                        <input
                            className="auth-input"
                            type="text"
                            placeholder="Dirección de facturación"
                            required
                            onChange={e =>
                                setFormData({
                                    ...formData,
                                    direccion_facturacion: e.target.value
                                })
                            }
                        />

                        {/* CÓDIGO POSTAL */}
                        <input
                            className="auth-input"
                            type="text"
                            placeholder="Código postal"
                            required
                            onChange={e =>
                                setFormData({
                                    ...formData,
                                    codigo_postal: e.target.value
                                })
                            }
                        />

                        {/* EMAIL */}
                        <input
                            className="auth-input"
                            type="email"
                            placeholder="Correo electrónico"
                            required
                            onChange={e =>
                                setFormData({
                                    ...formData,
                                    email: e.target.value
                                })
                            }
                        />

                        {/* CONTRASEÑA */}
                        <input
                            className="auth-input"
                            type="password"
                            placeholder="Contraseña"
                            required
                            onChange={e =>
                                setFormData({
                                    ...formData,
                                    password: e.target.value
                                })
                            }
                        />

                    </div>

                    {/* BOTONES */}
                    <div style={{
                        display: 'flex',
                        gap: '1rem',
                        marginTop: '2.5rem'
                    }}>

                        {/* BOTÓN REGISTRARSE */}
                        <button
                            type="submit"
                            className="btn-auth-primary btn-auth-gold"
                            style={{ margin: 0 }}
                        >
                            Registrarse
                        </button>

                        {/* BOTÓN CANCELAR */}
                        <button
                            type="button"
                            className="btn-auth-primary"
                            style={{
                                margin: 0,
                                background: '#f3f4f6',
                                color: '#111827',
                                border: '1px solid #e5e7eb'
                            }}
                            onClick={onClose}
                        >
                            Cancelar
                        </button>

                    </div>

                </form>

            </div>

        </div>

    )
}

// Exportación del componente
export default RegisterModal