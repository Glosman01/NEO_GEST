// Importación de hooks de React
import React, { useState, useEffect } from 'react'
// Importación de componentes principales de la aplicación
import { Navbar, Hero, Catalog, Login, Dashboard, RegisterModal } from './components'
// Importación de componentes del módulo de comercio
import { Footer, CartDrawer } from './components/Commerce'
/*
========================================================
COMPONENTE PRINCIPAL DE LA APLICACIÓN
========================================================
Este componente controla toda la navegación interna
del sistema NeoGest.
Gestiona las vistas:
home → página principal de la tienda
login → inicio de sesión de clientes
admin-login → inicio de sesión administrativo
admin → panel de administración
También controla:
- Carrito de compras
- Búsqueda de productos
- Registro de usuarios
*/
function App() {
    /*
    ========================================================
    FUNCIÓN PARA DEFINIR LA VISTA INICIAL
    ========================================================
    Permite abrir directamente el login de administrador
    usando la URL:
    http://localhost:5173/#admin
    */
    const getInitialView = () => {
        if (window.location.hash === '#admin') return 'admin-login'
        return 'home'
    }
    /*
    ========================================================
    ESTADOS PRINCIPALES DE LA APLICACIÓN
    ========================================================
    */
    // Vista actual de la aplicación
    const [view, setView] = useState(getInitialView())
    // Controla si el modal de registro está abierto
    const [isRegisterOpen, setIsRegisterOpen] = useState(false)
    // Controla si el carrito está abierto
    const [isCartOpen, setIsCartOpen] = useState(false)
    // Texto de búsqueda de productos
    const [searchTerm, setSearchTerm] = useState('')
    // Productos agregados al carrito
    const [cartItems, setCartItems] = useState([])
    /*
    ========================================================
    LISTENER DE CAMBIO EN EL HASH DE LA URL
    ========================================================
    Permite cambiar entre vistas usando la URL.
    */
    useEffect(() => {
        const handleHashChange = () => {
            if (window.location.hash === '#admin') {
                setView('admin-login')
            } else if (window.location.hash === '') {
                setView('home')
            }
        }
        // Escucha cambios en la URL
        window.addEventListener('hashchange', handleHashChange)
        // Limpia el evento cuando el componente se desmonta
        return () => window.removeEventListener('hashchange', handleHashChange)
    }, [])
    /*
    ========================================================
    FUNCIÓN PARA AGREGAR PRODUCTOS AL CARRITO
    ========================================================
    */
    const addToCart = (product) => {
        // Agrega el producto al carrito
        setCartItems([...cartItems, product])
        // Abre automáticamente el carrito
        setIsCartOpen(true)
    }
    /*
    ========================================================
    FUNCIÓN PARA ELIMINAR PRODUCTOS DEL CARRITO
    ========================================================
    */
    const removeCartItem = (index) => {
        // Copia del carrito
        const newCart = [...cartItems]
        // Elimina el producto según su posición
        newCart.splice(index, 1)
        // Actualiza el carrito
        setCartItems(newCart)
    }
    /*
    ========================================================
    RENDER PRINCIPAL DE LA APLICACIÓN
    ========================================================
    */
    return (
        <div className="app-container">
            {/* ====================================================
               VISTA PRINCIPAL (TIENDA)
            ==================================================== */}
            {view === 'home' && (
                <>
                    {/* BARRA DE NAVEGACIÓN */}
                    <Navbar
                        // Ir al login
                        onLoginClick={() => setView('login')}
                        // Abrir registro
                        onRegisterClick={() => setIsRegisterOpen(true)}
                        // Buscar productos
                        onSearch={setSearchTerm}
                        // Cantidad de productos en carrito
                        cartItemsCount={cartItems.length}
                        // Abrir carrito
                        onCartClick={() => setIsCartOpen(true)}
                    />
                    {/* SECCIÓN HERO (PORTADA) */}
                    <Hero />
                    {/* CATÁLOGO DE PRODUCTOS */}
                    <Catalog
                        searchTerm={searchTerm}
                        addToCart={addToCart}
                    />
                    {/* PIE DE PÁGINA */}
                    <Footer />
                    {/* MODAL DE REGISTRO */}
                    {isRegisterOpen && (
                        <RegisterModal
                            onClose={() => setIsRegisterOpen(false)}
                        />
                    )}
                    {/* CARRITO DE COMPRAS */}
                    <CartDrawer
                        isOpen={isCartOpen}
                        onClose={() => setIsCartOpen(false)}
                        items={cartItems}
                        onRemove={removeCartItem}
                    />
                </>
            )}
            {/* ====================================================
               VISTA LOGIN
            ==================================================== */}
            {(view === 'login' || view === 'admin-login') && (
                <Login
                    // Si el login es exitoso
                    onLoginSuccess={(role) =>
                        setView(role === 'admin' ? 'admin' : 'home')
                    }
                    // Volver a la tienda
                    onBack={() => setView('home')}
                    // Determina si es login admin
                    isAdminLogin={view === 'admin-login'}
                />
            )}
            {/* ====================================================
               PANEL ADMINISTRADOR
            ==================================================== */}
            {view === 'admin' && (
                <Dashboard
                    onLogout={() => {
                        // Elimina hash de admin
                        window.location.hash = ''
                        // Regresa a la tienda
                        setView('home')
                    }}
                />
            )}
        </div>
    )
}
// Exportación del componente principal
export default App