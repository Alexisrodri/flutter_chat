# Chat App con Flutter, Socket.IO, Node.js, y MongoDB

Este proyecto es una aplicación de chat en tiempo real desarrollada con Flutter para el frontend y Node.js con Express para el backend. Utiliza Socket.IO para la comunicación en tiempo real y MongoDB/MongoDB Atlas para el almacenamiento de datos.

## Preview

https://github.com/user-attachments/assets/4b7533a9-0a1f-4f84-8b66-fbaccfd4ca79

## Características

- **Chat en tiempo real**: Usa Socket.IO para la comunicación bidireccional entre el cliente (Flutter) y el servidor (Node.js).
- **Flutter como frontend**: Una interfaz de usuario moderna y receptiva usando Flutter.
- **Express y Node.js como backend**: Un servidor eficiente utilizando Express.
- **MongoDB**: Almacenamiento de datos localmente o en la nube con MongoDB Atlas.
- **Autenticación de usuarios**: Maneja sesiones de usuarios y autenticación segura (si se ha implementado).
- **Conexión escalable**: La conexión a MongoDB Atlas permite que el sistema escale sin problemas.

## Tecnologías Utilizadas

- **Frontend**:

  - Flutter
  - Dart
  - Socket.IO (cliente)

- **Backend**:
  - Node.js
  - Express
  - Socket.IO (servidor)
  - MongoDB / MongoDB Atlas

## Requisitos Previos

Antes de empezar, asegúrate de tener las siguientes herramientas instaladas:

- Node.js (versión 12 o superior)
- Flutter (versión estable)
- MongoDB o una cuenta en [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
- Socket.IO (versión 4 o superior)

## Instalación

Instalar dependencias

```
flutter pub get
```

## Uso

1. Inicia el servidor || asegúrate de que MongoDB o MongoDB Atlas estén configurados correctamente.
2. Corre la aplicación Flutter en tu dispositivo o emulador.
3. Regístrate o inicia sesión y comienza a chatear en tiempo real con otros usuarios.

# Estructura del proyecto

- [global/](.\lib\global)
  - Manejo de enviroments
- [helpers/](.\lib\helpers)
  - Widgets helpers
- [mappers/](.\lib\mappers)
  - Transformaciones de datos entre el backend y el frontend
- [models/](.\lib\models)
  - Modelos de datos utilizados en la app de Flutter
- [pages/](.\lib\pages)
  - Pantallas principales de la aplicació
- [routes/](.\lib\routes)
  - Definición de las rutas y navegación de la aplicación
- [services/](.\lib\services)
  - Servicios que interactúan con APIs y manejan la lógica de negocios
- [widgets/](.\lib\widgets)
  - Componentes reutilizables personalizados
