/*
========================================================
ARCHIVO DE EXPORTACIÓN DE COMPONENTES
========================================================
Este archivo funciona como un "punto central de exportación"
para los componentes del sistema.
Permite importar múltiples componentes desde un solo archivo
en lugar de importar cada uno por separado en otros módulos.
Ejemplo sin este archivo:
import Navbar from './components/Navbar'
import Hero from './components/Hero'
import Catalog from './components/Catalog'
Ejemplo con este archivo:
import { Navbar, Hero, Catalog } from './components'
Esto mejora la organización del código y facilita el mantenimiento.
*/
// Importación de componentes de la página principal (Landing Page)
import { Navbar, Hero } from './LandingElements'
// Importación del componente de catálogo de productos
import Catalog from './Catalog'
// Importación del componente de inicio de sesión
import Login from './Login'
// Importación del panel administrativo o dashboard
import Dashboard from './Dashboard'
// Importación del modal de registro de usuarios
import RegisterModal from './RegisterModal'
/*
Aquí se exportan todos los componentes para que puedan
ser utilizados desde otros archivos del proyecto.
Esto permite hacer importaciones más limpias.
*/
export {
  Navbar,          // Barra de navegación principal
  Hero,            // Sección principal de la landing page
  Catalog,         // Catálogo de productos
  Login,           // Formulario de inicio de sesión
  Dashboard,       // Panel de administración
  RegisterModal    // Modal para registro de usuarios
}