# TransporteVentas3 — Sistema de Ventas para Empresa de Transportes

Proyecto final del curso **Técnicas de Programación Orientada a Objetos**  
Universidad Privada del Norte — Ingeniería de Sistemas — 5to Ciclo — 2026-1

---

## ¿Qué es este sistema?

TransporteVentas3 es una aplicación de escritorio desarrollada en Java que permite a una empresa de transportes gestionar sus ventas de pasajes de forma digital. Antes de tener este sistema, todo se hacía a mano con boletas físicas y cuadernos, lo que generaba errores y pérdida de información. Con este sistema, el personal puede registrar rutas, vehículos, conductores y emitir boletos desde una interfaz gráfica, y todos los datos quedan guardados en una base de datos SQL Server.

---

## Integrantes del equipo

| Nombre | Rol en el proyecto |
|---|---|
| Chavez Huaman Angel Jhair | Analista de Sistema |
| Diaz Arribasplata Jhonalyn | Analista de Sistema |
| Huaman Cuenca Ruth Berania | Tester / Documentador |
| Pedraza Huaman Franklin Julinho | Líder de Proyecto / Coordinador |
| Revilla Tello Alonzo | Líder de Proyecto / Coordinador |

---

## ¿Qué puede hacer el sistema?

- **Iniciar sesión** con tres tipos de usuario: Administrador, Vendedor y Supervisor, cada uno con acceso a diferentes módulos
- **Gestionar rutas** de transporte con origen fijo en Trujillo, validando que el destino sea diferente al origen
- **Registrar vehículos** (Buses y Combis) con validación de marca, modelo, placa en formato XXX-XXX, año entre 1990 y 2026, y capacidad máxima según el tipo
- **Registrar conductores** con validación de DNI de 8 dígitos, teléfono peruano de 9 dígitos iniciando en 9, y categorías de licencia A-IIa hasta A-IIIc
- **Emitir boletos de pasaje** seleccionando ruta, vehículo y conductor desde listas desplegables, con descuentos automáticos según el tipo de cliente (Regular 0%, Frecuente 10%, Corporativo 15%)
- **Ver historial de boletos** con todos los datos del cliente incluyendo teléfono, y cancelar boletos si es necesario
- **Dashboard** con estadísticas en tiempo real: total de boletos, recaudación, rutas activas, vehículos y conductores

---

## Tecnologías utilizadas

| Tecnología | Versión | Para qué se usa |
|---|---|---|
| Java SE | 21 | Lenguaje principal del sistema |
| Apache NetBeans | 27 | Entorno de desarrollo (IDE) |
| Java Swing | — | Interfaz gráfica de usuario |
| SQL Server Express | 16.0 | Base de datos donde se guardan todos los registros |
| Microsoft JDBC Driver | 13.4.0 | Conexión entre Java y SQL Server |
| SQL Server Management Studio | 21 | Administración de la base de datos |

---

## Estructura de carpetas del proyecto

```
TransporteVentas3/
├── src/
│   └── transporteventas3/
│       ├── Persona.java              ← Clase abstracta padre
│       ├── Cliente.java              ← Hereda de Persona
│       ├── Conductor.java            ← Hereda de Persona
│       ├── Vendedor.java             ← Hereda de Persona
│       ├── Administrador.java        ← Hereda de Persona
│       ├── Supervisor.java           ← Hereda de Persona
│       ├── Vehiculo.java             ← Clase abstracta padre
│       ├── Bus.java                  ← Hereda de Vehiculo
│       ├── Conbi.java                ← Hereda de Vehiculo
│       ├── Ruta.java                 ← Entidad de dominio
│       ├── Boleto.java               ← Entidad de dominio
│       ├── UsuarioSistema.java       ← Interfaz de autenticación
│       ├── ConexionDB.java           ← Conexión JDBC a SQL Server
│       ├── RutaDAO.java              ← CRUD de rutas
│       ├── VehiculoDAO.java          ← CRUD de vehículos
│       ├── ConductorDAO.java         ← CRUD de conductores
│       ├── BoletoDAO.java            ← CRUD de boletos
│       ├── VendedorDAO.java          ← Autenticación de usuarios
│       ├── ControladorRuta.java      ← Lógica de negocio rutas
│       ├── ControladorVehiculo.java  ← Lógica de negocio vehículos
│       ├── ControladorConductor.java ← Lógica de negocio conductores
│       ├── ControladorBoleto.java    ← Lógica de negocio boletos
│       ├── ControladorVendedor.java  ← Lógica de autenticación
│       ├── LoginGUI.java             ← Pantalla de inicio de sesión
│       ├── MenuPrincipalGUI.java     ← Interfaz principal del sistema
│       └── Transporteventas3.java    ← Punto de entrada (main)
├── jdbc/
│   ├── mssql-jdbc-13.4.0.jre11.jar  ← Driver JDBC
│   └── sqljdbc_auth.dll              ← Autenticación Windows
└── SQLQuery1.sql                     ← Script para crear la base de datos
```

---

## Base de datos

La base de datos se llama **TransporteVentas** y tiene 11 tablas:

```
personas          → datos personales base (herencia)
vendedores        → usuarios del sistema con rol vendedor
administradores   → usuarios con rol administrador
supervisores      → usuarios con rol supervisor
clientes          → clientes que compran boletos
conductores       → conductores de los vehículos
vehiculos         → flota de transporte (buses y combis)
buses             → datos específicos de cada bus
combis            → datos específicos de cada combi
rutas             → trayectos disponibles desde Trujillo
boletos           → registro de todas las ventas
```

---

## Usuarios del sistema

| Usuario | Contraseña | Qué puede hacer |
|---|---|---|
| `admin` | `admin123` | Todo: rutas, vehículos, conductores, boletos, reportes |
| `vendedor1` | `venta2024` | Emitir boletos y ver el historial |
| `supervisor` | `super2024` | Ver rutas, vehículos, conductores y boletos (solo consulta) |

---

## Cómo instalar y ejecutar

Para instalar el sistema en tu computadora, sigue el **Manual de Instalación y Ejecución** que está incluido en los archivos del proyecto. El manual explica paso a paso cómo configurar SQL Server, agregar el driver JDBC y ejecutar el proyecto en NetBeans.

De forma resumida, los pasos son:

1. Verificar que SQL Server Express esté activo en `services.msc`
2. Ejecutar el archivo `SQLQuery1.sql` en SQL Server Management Studio
3. Copiar `mssql-jdbc-13.4.0.jre11.jar` y `sqljdbc_auth.dll` a `C:\jdbc\`
4. Abrir la carpeta `TransporteVentas3` en NetBeans con **File → Open Project**
5. Agregar el JAR en **Properties → Libraries → Classpath**
6. Verificar el nombre del servidor en `ConexionDB.java`
7. Compilar con **Shift+F11** y ejecutar con **F6**

---

## Principios de POO aplicados

**Herencia:** Se crearon dos jerarquías. La clase abstracta `Persona` es padre de `Cliente`, `Conductor`, `Vendedor`, `Administrador` y `Supervisor`. La clase abstracta `Vehiculo` es padre de `Bus` y `Conbi`.

**Encapsulamiento:** Todos los atributos son privados o protegidos y se acceden mediante métodos get/set con validaciones incluidas.

**Polimorfismo:** Los métodos `ver_datos()` y `validarCapacidad()` están definidos en las clases abstractas y cada subclase los implementa de manera diferente.

**Abstracción:** Las clases `Persona` y `Vehiculo` no pueden instanciarse directamente porque representan conceptos generales, no entidades concretas.

**Interfaz:** `UsuarioSistema` define el contrato común que implementan `Vendedor`, `Administrador` y `Supervisor` para el proceso de autenticación.

---

## Repositorio

https://github.com/julinhopedraza18-beep/TransporteVentas3.git

---

*Universidad Privada del Norte — Cajamarca, Perú — 2026*
