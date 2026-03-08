import React, { useState, useEffect } from 'react'

export const Navbar = ({ onLoginClick, onRegisterClick, onSearch, cartItemsCount, onCartClick }) => {
    const [isHomeOpen, setIsHomeOpen] = useState(false)
    const [isOfficeOpen, setIsOfficeOpen] = useState(false)

    const categories = {
        hogar: [
            'Sala', 'Comedores', 'Lámparas', 'Mesas', 'Camas',
            'Sillones', 'Sofás', 'Sillas', 'Estantes', 'Cajones',
            'Nocheros', 'Repisas'
        ],
        oficina: [
            'Escritorios', 'Sillas', 'Lámparas', 'Repisas',
            'Puertas', 'Ventanas', 'Sofás'
        ]
    }

    return (
        <nav className="glass" style={{ padding: '0.75rem 0', position: 'sticky', top: 0, zIndex: 1000, borderBottom: '1px solid var(--glass-border)' }}>
            <div className="container" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '3rem' }}>
                    <div style={{ fontSize: '1.75rem', fontWeight: '800', letterSpacing: '-1px', color: 'var(--secondary)' }}>
                        NEO<span style={{ color: 'var(--primary-dark)' }}>GEST</span>
                    </div>

                    <ul style={{ display: 'flex', gap: '2rem', listStyle: 'none', alignItems: 'center' }}>
                        <li><a href="#inicio" className="menu-link" style={{ fontWeight: 600 }}>Inicio</a></li>
                        <li className="nav-dropdown" onMouseEnter={() => setIsHomeOpen(true)} onMouseLeave={() => setIsHomeOpen(false)}>
                            <a href="#catalogo" className="menu-link" style={{ fontWeight: 600 }}>Hogar <i className="fas fa-chevron-down" style={{ fontSize: '0.7rem' }}></i></a>
                            <div className="nav-dropdown-content" style={{ display: isHomeOpen ? 'grid' : 'none', gridTemplateColumns: 'repeat(2, 1fr)', width: '400px' }}>
                                {categories.hogar.map(item => (
                                    <a key={item} href={`#${item.toLowerCase()}`} className="menu-link" style={{ padding: '0.5rem' }}>{item}</a>
                                ))}
                            </div>
                        </li>
                        <li className="nav-dropdown" onMouseEnter={() => setIsOfficeOpen(true)} onMouseLeave={() => setIsOfficeOpen(false)}>
                            <a href="#catalogo" className="menu-link" style={{ fontWeight: 600 }}>Oficina <i className="fas fa-chevron-down" style={{ fontSize: '0.7rem' }}></i></a>
                            <div className="nav-dropdown-content" style={{ display: isOfficeOpen ? 'grid' : 'none' }}>
                                {categories.oficina.map(item => (
                                    <a key={item} href={`#${item.toLowerCase()}`} className="menu-link" style={{ padding: '0.5rem' }}>{item}</a>
                                ))}
                            </div>
                        </li>
                        <li><a href="#nosotros" className="menu-link" style={{ fontWeight: 600 }}>Nosotros</a></li>
                        <li><a href="#contacto" className="menu-link" style={{ fontWeight: 600 }}>Contacto</a></li>
                    </ul>
                </div>

                <div style={{ display: 'flex', gap: '1.5rem', alignItems: 'center' }}>
                    <div style={{ position: 'relative' }}>
                        <input
                            type="text"
                            placeholder="Buscar muebles..."
                            className="input-premium"
                            style={{ width: '200px', paddingRight: '2.5rem' }}
                            onChange={(e) => onSearch(e.target.value)}
                        />
                        <span style={{ position: 'absolute', right: '1rem', top: '50%', transform: 'translateY(-50%)', opacity: 0.5 }}>
                            🔍
                        </span>
                    </div>

                    <div onClick={onCartClick} style={{ position: 'relative', cursor: 'pointer', fontSize: '1.2rem' }}>
                        🛒
                        {cartItemsCount > 0 && (
                            <span style={{
                                position: 'absolute', top: '-8px', right: '-8px', background: 'var(--primary)',
                                color: 'var(--secondary)', fontSize: '0.7rem', fontWeight: 'bold',
                                padding: '2px 6px', borderRadius: '50%', border: '2px solid white'
                            }}>
                                {cartItemsCount}
                            </span>
                        )}
                    </div>

                    <button onClick={onLoginClick} className="btn btn-outline" style={{ padding: '0.5rem 1.25rem' }}>Login</button>
                    <button onClick={onRegisterClick} className="btn btn-primary" style={{ padding: '0.5rem 1.25rem' }}>Unirse</button>
                </div>
            </div>
        </nav>
    )
}

export const Hero = () => {
    const [currentSlide, setCurrentSlide] = useState(0)
    const slides = [
        {
            title: 'Diseño Minimalista para tu Hogar',
            desc: 'Explora la elegancia funcional de nuestra nueva colección Nano Banana.',
            img: '/images/hero.png'
        },
        {
            title: 'Tu Oficina, Tu Santuario',
            desc: 'Eficiencia y confort en cada detalle con acabados premium.',
            img: '/images/comedor.png' // Placeholder for now
        },
        {
            title: 'Confort sin Límites',
            desc: 'Sofás y camas diseñados para el descanso definitivo.',
            img: '/images/sofa.png'
        },
        {
            title: 'Detalles que Enamoran',
            desc: 'Lámparas y accesorios que transforman cualquier espacio.',
            img: '/images/lamp.png'
        }
    ]

    useEffect(() => {
        const timer = setInterval(() => {
            setCurrentSlide((prev) => (prev + 1) % slides.length)
        }, 5000)
        return () => clearInterval(timer)
    }, [])

    return (
        <div className="container">
            <div className="slider-container animate-fade">
                {slides.map((slide, index) => (
                    <div key={index} className={`slide ${index === currentSlide ? 'active' : ''}`}>
                        <div className="slide-overlay"></div>
                        <img src={slide.img} alt={slide.title} className="slide-image" />
                        <div style={{ position: 'absolute', left: '4rem', zIndex: 2, color: 'white', maxWidth: '500px' }}>
                            <h1 style={{ fontSize: '4rem', marginBottom: '1rem', lineHeight: 1.1 }}>{slide.title}</h1>
                            <p style={{ fontSize: '1.25rem', opacity: 0.9, marginBottom: '2rem' }}>{slide.desc}</p>
                            <a href="#catalogo" className="btn btn-primary">Ver Colección ➜</a>
                        </div>
                    </div>
                ))}
                <div className="slider-controls">
                    {slides.map((_, index) => (
                        <button
                            key={index}
                            onClick={() => setCurrentSlide(index)}
                            style={{
                                width: '12px', height: '12px', borderRadius: '50%', border: 'none',
                                background: index === currentSlide ? 'var(--primary)' : 'rgba(255,255,255,0.3)',
                                cursor: 'pointer', transition: '0.3s'
                            }}
                        />
                    ))}
                </div>
            </div>
        </div>
    )
}
