import React, { useState } from 'react'

const Dashboard = ({ onLogout }) => {
    const [activeTab, setActiveTab] = useState('dashboard')

    const menuItems = [
        { id: 'dashboard', label: 'Dashboard', icon: '🏠' },
        { id: 'inventario', label: 'Inventario', icon: '📦' },
        { id: 'pedido', label: 'Pedidos', icon: '📑' },
        { id: 'envios', label: 'Envíos', icon: '🚚' },
        { id: 'facturacion', label: 'Facturación', icon: '💰' },
        { id: 'devolucion', label: 'Devolución', icon: '🔄' },
        { id: 'usuarios', label: 'Usuarios', icon: '👥' },
        { id: 'config', label: 'Configuración', icon: '⚙️' },
    ]

    const stats = [
        { label: 'Ventas Totales', value: '$45,200', change: '+12% vs mes anterior', isPositive: true },
        { label: 'Pedidos Pendientes', value: '24', change: 'Requieren atención', isPositive: false },
        { label: 'Productos en Stock', value: '1,250', change: '5 bajo stock mínimo', isPositive: false },
        { label: 'Envíos en Tránsito', value: '18', change: '', isPositive: true },
    ]

    return (
        <div className="dashboard-wrapper">
            <aside className="dashboard-sidebar">
                <div className="dashboard-logo">NEOGEST</div>

                <nav className="sidebar-nav">
                    {menuItems.map(item => (
                        <div
                            key={item.id}
                            className={`nav-item ${activeTab === item.id ? 'active' : ''}`}
                            onClick={() => setActiveTab(item.id)}
                        >
                            <span style={{ fontSize: '1.2rem' }}>{item.icon}</span>
                            {item.label}
                        </div>
                    ))}
                </nav>

                <div className="sidebar-footer" style={{ padding: '0 0.75rem' }}>
                    <div className="nav-item" onClick={onLogout} style={{ color: '#ff4d4d' }}>
                        <span>⬅️</span> Salir
                    </div>
                </div>
            </aside>

            <main className="dashboard-main">
                <header className="dashboard-header">
                    <h1 className="resumen-title">Resumen General</h1>

                    <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                        <div style={{ textAlign: 'right' }}>
                            <p style={{ fontWeight: 600, fontSize: '0.9rem', color: '#1a1a1a' }}>Hola, <span style={{ fontWeight: 800 }}>Administrador</span></p>
                        </div>
                        <div style={{ width: 40, height: 40, borderRadius: '50%', backgroundColor: '#e2e8f0' }}></div>
                    </div>
                </header>

                {activeTab === 'dashboard' && (
                    <>
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '1.5rem', marginBottom: '2.5rem' }}>
                            {stats.map((stat, index) => (
                                <div key={index} className="stat-card">
                                    <span className="stat-label">{stat.label}</span>
                                    <span className="stat-value">{stat.value}</span>
                                    <div className="stat-footer">
                                        {stat.isPositive ?
                                            <span style={{ color: '#10b981' }}>↑ {stat.change}</span> :
                                            <span style={{ color: '#f59e0b' }}>{stat.change}</span>
                                        }
                                    </div>
                                </div>
                            ))}
                        </div>

                        <div style={{ background: '#fff', borderRadius: '0.75rem', padding: '2rem', boxShadow: 'var(--shadow)' }}>
                            <h2 style={{ fontSize: '1.25rem', fontWeight: 700, marginBottom: '1.5rem', color: '#1a1a1a' }}>Últimos Pedidos</h2>
                            <table className="premium-table">
                                <thead>
                                    <tr>
                                        <th>ID Pedido</th>
                                        <th>Cliente</th>
                                        <th>Fecha</th>
                                        <th>Total</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>#ORD-001</td>
                                        <td>Ana García</td>
                                        <td>26 Nov 2023</td>
                                        <td>$1,200.00</td>
                                        <td><span className="badge badge-pending">Pendiente</span></td>
                                        <td><button className="btn-ver">Ver</button></td>
                                    </tr>
                                    <tr>
                                        <td>#ORD-002</td>
                                        <td>Carlos López</td>
                                        <td>25 Nov 2023</td>
                                        <td>$850.00</td>
                                        <td><span className="badge badge-success">Enviado</span></td>
                                        <td><button className="btn-ver">Ver</button></td>
                                    </tr>
                                    <tr>
                                        <td>#ORD-003</td>
                                        <td>María Rodríguez</td>
                                        <td>25 Nov 2023</td>
                                        <td>$2,300.00</td>
                                        <td><span className="badge badge-process">Procesando</span></td>
                                        <td><button className="btn-ver">Ver</button></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </>
                )}

                {/* Placeholders for new tabs */}
                {['pedido', 'facturacion', 'devolucion', 'inventario', 'usuarios', 'envios', 'config'].includes(activeTab) && activeTab !== 'dashboard' && (
                    <div style={{ background: '#fff', borderRadius: '0.75rem', padding: '3rem', textAlign: 'center', boxShadow: 'var(--shadow)' }}>
                        <h2 style={{ color: '#1a1a1a', marginBottom: '1rem' }}>Módulo de {menuItems.find(i => i.id === activeTab).label}</h2>
                        <p style={{ color: '#718096' }}>Este módulo está siendo actualizado con el nuevo diseño de alta fidelidad.</p>
                    </div>
                )}
            </main>
        </div>
    )
}

export default Dashboard
