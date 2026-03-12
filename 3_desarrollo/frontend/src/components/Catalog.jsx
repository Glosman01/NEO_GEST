// Importación de la librería React y del hook useState.
// React permite crear componentes de interfaz de usuario.
// useState se utiliza para manejar estados dentro de los componentes.
import React, { useState } from 'react'
// Arreglo que simula una base de datos de productos.
// Cada objeto representa un producto del catálogo de muebles.
const allProducts = [
    { id: 1, title: 'Sofá Modular Velvet', price: 4800000, img: '/images/sofa.png', category: 'Sala', area: 'Hogar' },
    { id: 2, title: 'Cama Queen Nordik', price: 3500000, img: '/images/cama.png', category: 'Camas', area: 'Hogar' },
    { id: 3, title: 'Comedor Minimalista', price: 5200000, img: '/images/comedor.png', category: 'Comedores', area: 'Hogar' },
    { id: 4, title: 'Lámpara de Pie Arco', price: 1200000, img: '/images/lamp.png', category: 'Lámparas', area: 'Hogar' },
    { id: 5, title: 'Escritorio Executive', price: 2800000, img: '/images/hero.png', category: 'Escritorios', area: 'Oficina' },
    { id: 6, title: 'Silla Ergonómica Pro', price: 1500000, img: '/images/sofa_cama.png', category: 'Sillas', area: 'Oficina' },
]
// Componente funcional Catalog.
// Recibe dos props:
// searchTerm → término de búsqueda ingresado por el usuario.
// addToCart → función que permite agregar un producto al carrito de compras.
const Catalog = ({ searchTerm, addToCart }) => {
    // Filtra los productos según el término de búsqueda.
    // Se revisa si el título o la categoría contienen el texto buscado.
    const filteredProducts = allProducts.filter(p =>
        p.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
        p.category.toLowerCase().includes(searchTerm.toLowerCase())
    )
    // Función para formatear el precio en pesos colombianos.
    // Utiliza la API Intl.NumberFormat para mostrar el valor como moneda.
    const formatPrice = (price) => {
        return new Intl.NumberFormat('es-CO', {
            style: 'currency',
            currency: 'COP',
            maximumFractionDigits: 0
        }).format(price)
    }
    // Renderizado del componente.
    return (
        // Sección principal del catálogo
        <section id="catalogo" className="container" style={{ padding: '6rem 0' }}>
            {/* Encabezado de la sección */}
            <div className="section-header" style={{ textAlign: 'center', marginBottom: '4rem' }}>
                <h2 style={{ fontSize: '3rem', fontWeight: 700, marginBottom: '1rem' }}>
                    Colección Exclusiva
                </h2>
                <p style={{ color: 'var(--text-light)', fontSize: '1.2rem' }}>
                    Piezas únicas diseñadas para transformar ambientes
                </p>
            </div>
            {/* Grid donde se muestran los productos */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))',
                gap: '2.5rem'
            }}>
                {/* Se recorren los productos filtrados */}
                {filteredProducts.map(product => (
                    // Tarjeta individual de producto
                    <div key={product.id} className="product-card">
                        {/* Contenedor de la imagen */}
                        <div style={{ overflow: 'hidden', height: '300px' }}>
                            <img
                                src={product.img}
                                alt={product.title}
                                style={{
                                    width: '100%',
                                    height: '100%',
                                    objectFit: 'cover',
                                    transition: '0.5s'
                                }}
                                className="product-image"
                            />
                        </div>
                        {/* Información del producto */}
                        <div style={{ padding: '1.5rem' }}>
                            {/* Categoría y área */}
                            <div style={{
                                display: 'flex',
                                justifyContent: 'space-between',
                                alignItems: 'center',
                                marginBottom: '0.5rem'
                            }}>
                                <span style={{
                                    fontSize: '0.8rem',
                                    fontWeight: 700,
                                    color: 'var(--primary-dark)',
                                    textTransform: 'uppercase',
                                    letterSpacing: '0.1em'
                                }}>
                                    {product.area} / {product.category}
                                </span>
                            </div>
                            {/* Nombre del producto */}
                            <h3 style={{ fontSize: '1.25rem', marginBottom: '1rem' }}>
                                {product.title}
                            </h3>
                            {/* Precio y botón de agregar al carrito */}
                            <div style={{
                                display: 'flex',
                                justifyContent: 'space-between',
                                alignItems: 'center'
                            }}>
                                {/* Precio formateado */}
                                <span style={{ fontSize: '1.5rem', fontWeight: 700 }}>
                                    {formatPrice(product.price)}
                                </span>
                                {/* Botón para agregar al carrito */}
                                <button
                                    onClick={() => addToCart(product)}
                                    className="btn btn-primary"
                                    style={{
                                        width: '50px',
                                        height: '50px',
                                        borderRadius: '50%',
                                        padding: 0
                                    }}
                                >
                                    ➕
                                </button>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
            {/* Mensaje cuando no se encuentran productos */}
            {filteredProducts.length === 0 && (
                <div style={{ textAlign: 'center', padding: '4rem' }}>
                    <h3>No encontramos productos para "{searchTerm}"</h3>
                    <p>Prueba con otros términos como "Sofa" o "Cama"</p>
                </div>
            )}
        </section>
    )
}
// Exportación del componente para poder utilizarlo en otras partes de la aplicación
export default Catalog