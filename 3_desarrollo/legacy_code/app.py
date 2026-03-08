from flask import Flask, render_template, request, redirect, url_for, session, flash

app = Flask(__name__)
app.secret_key = 'super_secret_key_neogest' # En producción usar variable de entorno

# --- DATOS SIMULADOS (MOCK DB) ---

products = [
    {
        "id": 1,
        "name": "Sofá Modular Velvet",
        "price": 1200.00,
        "category": "Sala",
        "image": "https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=800&auto=format&fit=crop"
    },
    {
        "id": 2,
        "name": "Mesa de Centro Nórdica",
        "price": 450.00,
        "category": "Sala",
        "image": "https://images.unsplash.com/photo-1532372320572-cda25653a26d?q=80&w=800&auto=format&fit=crop"
    },
    {
        "id": 3,
        "name": "Silla Eames Premium",
        "price": 180.00,
        "category": "Comedor",
        "image": "https://images.unsplash.com/photo-1519947486511-4639940be434?q=80&w=800&auto=format&fit=crop"
    },
    {
        "id": 4,
        "name": "Lámpara de Pie Arco",
        "price": 320.00,
        "category": "Iluminación",
        "image": "https://images.unsplash.com/photo-1513506003011-3b03c80165bd?q=80&w=800&auto=format&fit=crop"
    },
    {
        "id": 5,
        "name": "Escritorio Minimalista",
        "price": 550.00,
        "category": "Oficina",
        "image": "https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?q=80&w=800&auto=format&fit=crop"
    },
    {
        "id": 6,
        "name": "Estantería Industrial",
        "price": 420.00,
        "category": "Almacenaje",
        "image": "https://images.unsplash.com/photo-1594620302200-9a762244a156?q=80&w=800&auto=format&fit=crop"
    }
]

# Datos para el dashboard de admin
stats = {
    "sales": 45200,
    "sales_growth": 12,
    "pending_orders": 24,
    "stock_count": 1250,
    "low_stock": 5,
    "shipping": 18
}

recent_orders = [
    {"id": "#ORD-001", "client": "Ana García", "date": "26 Nov 2023", "total": 1200.00, "status": "pending", "status_label": "Pendiente"},
    {"id": "#ORD-002", "client": "Carlos López", "date": "25 Nov 2023", "total": 850.00, "status": "shipped", "status_label": "Enviado"},
    {"id": "#ORD-003", "client": "María Rodríguez", "date": "25 Nov 2023", "total": 2300.00, "status": "processing", "status_label": "Procesando"},
    {"id": "#ORD-004", "client": "Juan Pérez", "date": "24 Nov 2023", "total": 450.00, "status": "shipped", "status_label": "Enviado"}
]

# Usuarios (Simulados)
USERS = {
    "admin@neogest.com": {"password": "admin", "role": "admin", "name": "Administrador"},
    "cliente@neogest.com": {"password": "cliente", "role": "client", "name": "Cliente de Prueba"}
}

# --- RUTAS ---

@app.route('/')
def index():
    return render_template('index.html', products=products)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')
        
        user = USERS.get(email)
        
        if user and user['password'] == password:
            session['user'] = email
            session['role'] = user['role']
            session['name'] = user['name']
            
            if user['role'] == 'admin':
                return redirect(url_for('admin'))
            else:
                return redirect(url_for('index'))
        else:
            flash('Credenciales incorrectas', 'error')
            
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

@app.route('/admin')
def admin():
    if 'user' not in session or session.get('role') != 'admin':
        return redirect(url_for('login'))
        
    return render_template('admin.html', 
                         stats=stats, 
                         orders=recent_orders, 
                         user_name=session.get('name'))

if __name__ == '__main__':
    app.run(debug=True, port=3000)
