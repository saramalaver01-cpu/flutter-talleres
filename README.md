# Taller 1 - Flutter

## Información del estudiante

**Nombre:** Sara Milena Malaver Ospina  
**Código:** 230232010  
**Programa:** Ingeniería de Sistemas  
**Taller:** Taller 1 - Flutter  
**Rama de desarrollo:** `feature/taller1`

## Descripción

Este proyecto corresponde al Taller 1 de Flutter. En este taller se desarrolló una aplicación utilizando los conceptos básicos de construcción de interfaces y manejo de estado en Flutter.

La aplicación utiliza un `StatefulWidget` para controlar el estado de la interfaz y permite cambiar dinámicamente el título de la aplicación mediante `setState()`.

También se incorporaron imágenes desde Internet y desde los recursos locales del proyecto, además de diferentes widgets de diseño para organizar la interfaz.

## Funcionalidades

- Implementación de `HomePage` como `StatefulWidget`.
- Título inicial **"Hola, Flutter"**.
- Cambio dinámico del título mediante `setState()`.
- Cambio del título a **"¡Título cambiado!"**.
- Mensaje `SnackBar` con el texto **"Título actualizado"**.
- Uso de `Image.network()`.
- Uso de `Image.asset()`.
- Implementación de widgets adicionales.
- Organización de la interfaz mediante `Column`, `Padding` y `SizedBox`.
- Configuración de imágenes locales mediante `pubspec.yaml`.

## Estructura del proyecto

```text
flutter-talleres/
│
├── README.md
│
└── taller1/
    ├── android/
    ├── assets/
    │   └── images/
    │       └── flutter.png
    ├── lib/
    │   └── main.dart
    ├── test/
    ├── web/
    ├── pubspec.yaml
    └── ...
