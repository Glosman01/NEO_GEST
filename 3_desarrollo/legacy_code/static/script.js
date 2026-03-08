// Estado del carrito (Lógica básica de cliente)
let cart = [];

// DOM Elements
const cartCount = document.getElementById('cart-count');

// Inicialización
document.addEventListener('DOMContentLoaded', () => {
    updateCartCount();
});

// Lógica del Carrito
// Modificado para aceptar datos directamente desde el HTML/Flask loop
function addToCart(productId, name, price) {
    const product = { id: productId, name: name, price: price };

    cart.push(product);
    updateCartCount();

    // Feedback visual simple
    const btn = event.currentTarget;
    const originalContent = btn.innerHTML;
    btn.innerHTML = '<i class="fas fa-check"></i>';
    btn.style.backgroundColor = 'var(--accent-color)';
    btn.style.color = 'white';

    setTimeout(() => {
        btn.innerHTML = originalContent;
        btn.style.backgroundColor = '';
        btn.style.color = '';
    }, 1000);
}

function updateCartCount() {
    if (cartCount) {
        cartCount.textContent = cart.length;
    }
}

function toggleCart() {
    alert(`Tienes ${cart.length} productos en el carrito.\nTotal: $${cart.reduce((sum, p) => sum + p.price, 0).toFixed(2)}`);
}
