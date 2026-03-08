import React, { useState } from 'react'

const RegisterModal = ({ onClose }) => {
    const [formData, setFormData] = useState({
        nombre: '',
        apellido: '',
        telefono: '',
        celular: '',
        direccion: '',
        medio_pago: 'efectivo'
    })

    const handleSubmit = async (e) => {
        e.preventDefault()
        try {
            const response = await fetch('http://localhost:8000/register', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ ...formData, email: `${formData.nombre.toLowerCase()}@example.com`, password: 'password123' })
            })
            if (response.ok) {
                alert('Registro exitoso!')
                onClose()
            }
        } catch (error) {
            console.error('Error:', error)
        }
    }

    return (
        <div style={{
            position: 'fixed', top: 0, left: 0, width: '100%', height: '100%',
            backgroundColor: 'rgba(15, 23, 42, 0.4)', backdropFilter: 'blur(5px)',
            display: 'flex', justifyContent: 'center', alignItems: 'center', zIndex: 1000
        }}>
            <div className="auth-card" style={{ padding: '2.5rem', maxWidth: '440px' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 700, marginBottom: '2rem', textAlign: 'left', color: '#111827' }}>
                    Registrarse en Neogest
                </h2>

                <form onSubmit={handleSubmit}>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                        <input className="auth-input" type="text" placeholder="Nombres" required
                            onChange={e => setFormData({ ...formData, nombre: e.target.value })} />

                        <input className="auth-input" type="text" placeholder="Apellidos" required
                            onChange={e => setFormData({ ...formData, apellido: e.target.value })} />

                        <input className="auth-input" type="text" placeholder="Teléfono" required
                            onChange={e => setFormData({ ...formData, telefono: e.target.value })} />

                        <input className="auth-input" type="text" placeholder="Celular" required
                            onChange={e => setFormData({ ...formData, celular: e.target.value })} />

                        <input className="auth-input" type="text" placeholder="Dirección" required
                            onChange={e => setFormData({ ...formData, direccion: e.target.value })} />

                        <select className="auth-input" style={{ appearance: 'auto' }}
                            onChange={e => setFormData({ ...formData, medio_pago: e.target.value })}>
                            <option value="efectivo">Efectivo</option>
                            <option value="tarjeta">Tarjeta de Crédito/Débito</option>
                            <option value="transferencia">Transferencia</option>
                        </select>
                    </div>

                    <div style={{ display: 'flex', gap: '1rem', marginTop: '2.5rem' }}>
                        <button type="submit" className="btn-auth-primary btn-auth-gold" style={{ margin: 0 }}>
                            Registrarse
                        </button>
                        <button type="button" className="btn-auth-primary"
                            style={{ margin: 0, background: '#f3f4f6', color: '#111827', border: '1px solid #e5e7eb' }}
                            onClick={onClose}>
                            Cancelar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    )
}

export default RegisterModal
