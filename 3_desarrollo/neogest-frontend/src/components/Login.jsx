import React, { useState } from 'react'

const Login = ({ onLoginSuccess, onBack, isAdminLogin }) => {
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')

    const handleSubmit = (e) => {
        e.preventDefault()
        // Simple mock logic
        if (email === 'admin@neogest.com' && password === 'admin123') {
            onLoginSuccess('admin')
        } else {
            onLoginSuccess('cliente')
        }
    }

    return (
        <div className="auth-container">
            <div className="auth-card">
                <div className="auth-logo">
                    NEO<span>GEST</span>
                </div>

                <h1 className="auth-title">
                    {isAdminLogin ? 'Acceso Administrativo' : 'Bienvenido'}
                </h1>
                <p className="auth-subtitle">
                    {isAdminLogin
                        ? 'Ingresa tus credenciales para gestionar Neogest'
                        : 'Ingresa a tu cuenta para continuar'}
                </p>

                <form onSubmit={handleSubmit}>
                    <div className="auth-form-group">
                        <label className="auth-label">Correo Electrónico</label>
                        <input
                            className="auth-input"
                            type="email"
                            placeholder="ejemplo@neogest.com"
                            required
                            onChange={e => setEmail(e.target.value)}
                        />
                    </div>

                    <div className="auth-form-group">
                        <label className="auth-label">Contraseña</label>
                        <input
                            className="auth-input"
                            type="password"
                            placeholder="........"
                            required
                            onChange={e => setPassword(e.target.value)}
                        />
                    </div>

                    <button type="submit" className="btn-auth-primary">Ingresar</button>
                </form>

                <div className="auth-test-credentials">
                    <p style={{ fontWeight: 600, marginBottom: '0.25rem' }}>Credenciales de prueba:</p>
                    <p>Admin: admin@neogest.com / admin</p>
                    <p>Cliente: cliente@neogest.com / cliente</p>
                </div>

                <p className="auth-footer-text">
                    ¿No tienes cuenta? <span className="auth-link-gold">Regístrate</span>
                </p>

                <span className="auth-link-secondary" onClick={onBack}>Volver a la tienda</span>
            </div>
        </div>
    )
}

export default Login
