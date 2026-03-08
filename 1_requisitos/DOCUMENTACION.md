# Documentación del Proyecto Neogest

## Descripción General
Neogest es una plataforma de **Tienda Online** especializada en la venta de muebles, que integra funcionalidades avanzadas para la gestión de inventarios y logística de envíos. El sistema está diseñado para soportar múltiples roles de usuario y garantizar una experiencia fluida tanto para clientes como para el personal administrativo.

## Actores del Sistema (Roles)
Según el análisis de los diagramas de clases y casos de uso, se identifican los siguientes roles:

1.  **Administrador (Rol 1)**:
    - Acceso total al sistema.
    - Gestión de usuarios, roles y configuración global.
2.  **Empleado de Logística (Rol 2)**:
    - Encargado de la gestión de envíos (`Envio`).
    - Control de stock y movimientos de inventario (`MovimientoInventario`).
3.  **Cliente (Rol 3)**:
    - Usuario final que navega el catálogo.
    - Realiza pedidos y pagos.

## Módulos Principales

### 1. Módulo de Ventas (Frontend Cliente)
- **Catálogo de Productos**: Visualización de muebles con detalles (precio, descripción, imagen).
- **Carrito de Compras**: Gestión temporal de productos seleccionados antes del pago.
- **Pedidos**: Registro de la transacción (`Pedido`, `DetallePedido`).

### 2. Módulo de Inventario y Logística (Backend/Admin)
- **Control de Stock**: Registro de entradas y salidas de productos en bodega.
- **Gestión de Envíos**: Asignación de códigos de seguimiento y transportadoras a los pedidos despachados.

## Requisitos No Funcionales (RNF)
- **Responsividad**: La interfaz debe adaptarse a dispositivos móviles y de escritorio.
- **Disponibilidad**: Alta disponibilidad (99.9%) para el módulo de tienda.
- **Escalabilidad**: Diseño de base de datos optimizado para el crecimiento de registros de inventario.

## Modelo de Datos (Entidades Clave)
- **Usuario**: `id`, `nombre`, `email`, `password`, `rol_id`.
- **Producto**: `id`, `nombre`, `precio`, `stock`, `categoria_id`.
- **Pedido**: `id`, `fecha`, `total`, `estado`, `usuario_id`.
- **Envio**: `id`, `pedido_id`, `codigo_seguimiento`, `transportadora`.

---
*Documentación generada automáticamente por Antigravity basada en los archivos del proyecto.*
