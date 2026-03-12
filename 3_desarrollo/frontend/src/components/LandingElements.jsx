// Importación de React y Hooks necesarios
import React, { useState, useEffect } from 'react'
/*
========================================================
COMPONENTE NAVBAR (BARRA DE NAVEGACIÓN)
========================================================
Este componente representa la barra superior del sitio web.
Contiene:
- Logo de la empresa
- Menú de navegación
- Categorías desplegables
- Buscador de productos
- Icono de carrito
- Botones de login y registro
Props que recibe:
onLoginClick → función que abre el login
onRegisterClick → función que abre el registro
onSearch → función para buscar productos
cartItemsCount → número de productos en el carrito
onCartClick → abrir el carrito
*/
export const Navbar = ({ onLoginClick, onRegisterClick, onSearch, cartItemsCount, onCartClick }) => {
    // Estado para controlar menú desplegable de Hogar
    const [isHomeOpen, setIsHomeOpen] = useState(false)
    // Estado para controlar menú desplegable de Oficina
    const [isOfficeOpen, setIsOfficeOpen] = useState(false)
    /*
    ========================================================
    CATEGORÍAS DEL CATÁLOGO
    ========================================================
    Se definen las categorías disponibles para cada tipo
    de catálogo del sistema (hogar y oficina)
    */
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
        /*
        ====================================================
        CONTENEDOR PRINCIPAL DE LA NAVBAR
        ====================================================
        */
        <nav
            className="glass"
            style={{
                padding: '0.75rem 0',
                position: 'sticky',
                top: 0,
                zIndex: 1000,
                borderBottom: '1px solid var(--glass-border)'
            }}
        >
            <div className="container" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                {/* LOGO + MENÚ PRINCIPAL */}
                <div style={{ display: 'flex', alignItems: 'center', gap: '3rem' }}>
                    {/* LOGO DEL SISTEMA */}
                    <div style={{ fontSize: '1.75rem', fontWeight: '800', letterSpacing: '-1px', color: 'var(--secondary)' }}>
                        NEO<span style={{ color: 'var(--primary-dark)' }}>GEST</span>
                    </div>
                    {/* MENÚ PRINCIPAL DE NAVEGACIÓN */}
                    <ul style={{ display: 'flex', gap: '2rem', listStyle: 'none', alignItems: 'center' }}>
                        {/* LINK INICIO */}
                        <li>
                            <a href="#inicio" className="menu-link" style={{ fontWeight: 600 }}>
                                Inicio
                            </a>
                        </li>
                        {/* MENÚ DESPLEGABLE HOGAR */}
                        <li
                            className="nav-dropdown"
                            onMouseEnter={() => setIsHomeOpen(true)}
                            onMouseLeave={() => setIsHomeOpen(false)}
                        >
                            <a href="#catalogo" className="menu-link" style={{ fontWeight: 600 }}>
                                Hogar
                                <i className="fas fa-chevron-down" style={{ fontSize: '0.7rem' }}></i>
                            </a>
                            {/* CONTENIDO DEL DROPDOWN */}
                            <div
                                className="nav-dropdown-content"
                                style={{
                                    display: isHomeOpen ? 'grid' : 'none',
                                    gridTemplateColumns: 'repeat(2, 1fr)',
                                    width: '400px'
                                }}
                            >
                                {/* LISTA DE CATEGORÍAS HOGAR */}
                                {categories.hogar.map(item => (
                                    <a
                                        key={item}
                                        href={`#${item.toLowerCase()}`}
                                        className="menu-link"
                                        style={{ padding: '0.5rem' }}
                                    >
                                        {item}
                                    </a>
                                ))}
                            </div>
                        </li>
                        {/* MENÚ DESPLEGABLE OFICINA */}
                        <li
                            className="nav-dropdown"
                            onMouseEnter={() => setIsOfficeOpen(true)}
                            onMouseLeave={() => setIsOfficeOpen(false)}
                        >
                            <a href="#catalogo" className="menu-link" style={{ fontWeight: 600 }}>
                                Oficina
                                <i className="fas fa-chevron-down" style={{ fontSize: '0.7rem' }}></i>
                            </a>
                            <div
                                className="nav-dropdown-content"
                                style={{ display: isOfficeOpen ? 'grid' : 'none' }}
                            >
                                {/* LISTA DE CATEGORÍAS OFICINA */}
                                {categories.oficina.map(item => (
                                    <a
                                        key={item}
                                        href={`#${item.toLowerCase()}`}
                                        className="menu-link"
                                        style={{ padding: '0.5rem' }}
                                    >
                                        {item}
                                    </a>
                                ))}
                            </div>
                        </li>
                        {/* LINKS INFORMATIVOS */}
                        <li><a href="#nosotros" className="menu-link" style={{ fontWeight: 600 }}>Nosotros</a></li>
                        <li><a href="#contacto" className="menu-link" style={{ fontWeight: 600 }}>Contacto</a></li>
                    </ul>
                </div>
                {/* SECCIÓN DERECHA: BUSCADOR + CARRITO + LOGIN */}
                <div style={{ display: 'flex', gap: '1.5rem', alignItems: 'center' }}>
                    {/* BUSCADOR DE PRODUCTOS */}
                    <div style={{ position: 'relative' }}>
                        <input
                            type="text"
                            placeholder="Buscar muebles..."
                            className="input-premium"
                            style={{ width: '200px', paddingRight: '2.5rem' }}
                            onChange={(e) => onSearch(e.target.value)}
                        />
                        <span
                            style={{
                                position: 'absolute',
                                right: '1rem',
                                top: '50%',
                                transform: 'translateY(-50%)',
                                opacity: 0.5
                            }}
                        >
                            🔍
                        </span>
                    </div>
                    {/* ICONO DEL CARRITO */}
                    <div
                        onClick={onCartClick}
                        style={{ position: 'relative', cursor: 'pointer', fontSize: '1.2rem' }}
                    >
                        🛒
                        {/* CONTADOR DE PRODUCTOS */}
                        {cartItemsCount > 0 && (
                            <span
                                style={{
                                    position: 'absolute',
                                    top: '-8px',
                                    right: '-8px',
                                    background: 'var(--primary)',
                                    color: 'var(--secondary)',
                                    fontSize: '0.7rem',
                                    fontWeight: 'bold',
                                    padding: '2px 6px',
                                    borderRadius: '50%',
                                    border: '2px solid white'
                                }}
                            >
                                {cartItemsCount}
                            </span>
                        )}
                    </div>
                    {/* BOTÓN LOGIN */}
                    <button
                        onClick={onLoginClick}
                        className="btn btn-outline"
                        style={{ padding: '0.5rem 1.25rem' }}
                    >
                        Login
                    </button>
                    {/* BOTÓN REGISTRO */}
                    <button
                        onClick={onRegisterClick}
                        className="btn btn-primary"
                        style={{ padding: '0.5rem 1.25rem' }}
                    >
                        Unirse
                    </button>
                </div>
            </div>
        </nav>
    )
}
/*
========================================================
COMPONENTE HERO (SLIDER PRINCIPAL)
========================================================
Este componente representa la sección principal de la
landing page con un slider automático.
Características:
- Cambio automático de imágenes
- Texto promocional
- Botón de acceso al catálogo
*/
export const Hero = () => {
    // Estado del slide actual
    const [currentSlide, setCurrentSlide] = useState(0)
    /*
    LISTA DE SLIDES DEL CARRUSEL
    */
    const slides = [
        {
            title: 'Diseño Minimalista para tu Hogar',
            desc: 'Explora la elegancia funcional de nuestra nueva colección Nano Banana.',
            img: '/images/hero.png'
        },
        {
            title: 'Tu Oficina, Tu Santuario',
            desc: 'Eficiencia y confort en cada detalle con acabados premium.',
            img: '/images/comedor.png'
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
    /*
    ====================================================
    SLIDER AUTOMÁTICO
    ====================================================
    Cambia de slide cada 5 segundos
    */
    useEffect(() => {
        const timer = setInterval(() => {
            setCurrentSlide((prev) => (prev + 1) % slides.length)
        }, 5000)
        return () => clearInterval(timer)
    }, [])
    return (
        <div className="container">
            <div className="slider-container animate-fade">
                {/* GENERACIÓN DE LOS SLIDES */}
                {slides.map((slide, index) => (
                    <div
                        key={index}
                        className={`slide ${index === currentSlide ? 'active' : ''}`}
                    >
                        <div className="slide-overlay"></div>
                        <img
                            src={slide.img}
                            alt={slide.title}
                            className="slide-image"
                        />
                        {/* TEXTO DEL SLIDE */}
                        <div
                            style={{
                                position: 'absolute',
                                left: '4rem',
                                zIndex: 2,
                                color: 'white',
                                maxWidth: '500px'
                            }}
                        >
                            <h1 style={{ fontSize: '4rem', marginBottom: '1rem', lineHeight: 1.1 }}>
                                {slide.title}
                            </h1>
                            <p style={{ fontSize: '1.25rem', opacity: 0.9, marginBottom: '2rem' }}>
                                {slide.desc}
                            </p>
                            <a href="#catalogo" className="btn btn-primary">
                                Ver Colección ➜
                            </a>
                        </div>
                    </div>
                ))}
                {/* CONTROLES DEL SLIDER */}
                <div className="slider-controls">
                    {slides.map((_, index) => (
                        <button
                            key={index}
                            onClick={() => setCurrentSlide(index)}
                            style={{
                                width: '12px',
                                height: '12px',
                                borderRadius: '50%',
                                border: 'none',
                                background: index === currentSlide
                                    ? 'var(--primary)'
                                    : 'rgba(255,255,255,0.3)',
                                cursor: 'pointer',
                                transition: '0.3s'
                            }}
                        />
                    ))}
                </div>
            </div>
        </div>
    )
}