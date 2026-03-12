import React, { useState, useEffect } from 'react'
import { Navbar, Hero, Catalog, Login, Dashboard, RegisterModal } from './components'
import { Footer, CartDrawer } from './components/Commerce'

function App() {
    // Check if the URL has #admin to determine initial view
    const getInitialView = () => {
        if (window.location.hash === '#admin') return 'admin-login'
        return 'home'
    }

    const [view, setView] = useState(getInitialView()) // home, login, admin, admin-login
    const [isRegisterOpen, setIsRegisterOpen] = useState(false)
    const [isCartOpen, setIsCartOpen] = useState(false)
    const [searchTerm, setSearchTerm] = useState('')
    const [cartItems, setCartItems] = useState([])

    // Listen for hash changes to allow direct access via URL
    useEffect(() => {
        const handleHashChange = () => {
            if (window.location.hash === '#admin') {
                setView('admin-login')
            } else if (window.location.hash === '') {
                setView('home')
            }
        }
        window.addEventListener('hashchange', handleHashChange)
        return () => window.removeEventListener('hashchange', handleHashChange)
    }, [])

    const addToCart = (product) => {
        setCartItems([...cartItems, product])
        setIsCartOpen(true)
    }

    const removeCartItem = (index) => {
        const newCart = [...cartItems]
        newCart.splice(index, 1)
        setCartItems(newCart)
    }

    return (
        <div className="app-container">
            {view === 'home' && (
                <>
                    <Navbar
                        onLoginClick={() => setView('login')}
                        onRegisterClick={() => setIsRegisterOpen(true)}
                        onSearch={setSearchTerm}
                        cartItemsCount={cartItems.length}
                        onCartClick={() => setIsCartOpen(true)}
                    />
                    <Hero />
                    <Catalog searchTerm={searchTerm} addToCart={addToCart} />
                    <Footer />

                    {isRegisterOpen && <RegisterModal onClose={() => setIsRegisterOpen(false)} />}
                    <CartDrawer
                        isOpen={isCartOpen}
                        onClose={() => setIsCartOpen(false)}
                        items={cartItems}
                        onRemove={removeCartItem}
                    />
                </>
            )}

            {(view === 'login' || view === 'admin-login') && (
                <Login
                    onLoginSuccess={(role) => setView(role === 'admin' ? 'admin' : 'home')}
                    onBack={() => setView('home')}
                    isAdminLogin={view === 'admin-login'}
                />
            )}

            {view === 'admin' && (
                <Dashboard onLogout={() => {
                    window.location.hash = ''
                    setView('home')
                }} />
            )}
        </div>
    )
}

export default App
