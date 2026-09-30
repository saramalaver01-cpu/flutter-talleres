# Talleres de Flutter

## Información del estudiante

**Nombre:** Sara Milena Malaver Ospina  
**Código:** 230232010  
**Programa:** Ingeniería de Sistemas  

## Descripción

Este repositorio contiene los talleres desarrollados durante la asignatura para practicar diferentes conceptos y funcionalidades de Flutter.

Cada taller se encuentra organizado en su propia carpeta y cuenta con su respectiva rama de desarrollo siguiendo un flujo de trabajo basado en GitFlow.

## Talleres

### Taller 1 - Flutter

**Carpeta:** `taller1/`  
**Rama:** `feature/taller1`

En este taller se trabajaron conceptos básicos de construcción de interfaces y manejo de estado en Flutter.

Se implementó:

- `StatefulWidget`.
- Manejo del estado mediante `setState()`.
- Cambio dinámico del título de la aplicación.
- Uso de `SnackBar`.
- `Image.network()`.
- `Image.asset()`.
- Widgets adicionales como `Container` y `ListView`.
- Organización de la interfaz mediante `Column`, `Padding` y `SizedBox`.

---

### Taller 2 - Ejecución en segundo plano

**Carpeta:** `taller_segundo_plano/`  
**Rama:** `feature/taller_segundo_plano`

En este taller se trabajaron conceptos relacionados con asincronía y ejecución de tareas en segundo plano en Flutter.

Se implementó:

- `Future`.
- `Future.delayed`.
- `async/await`.
- Estados de carga, éxito y error.
- `Timer`.
- Cronómetro con iniciar, pausar, reanudar y reiniciar.
- Cancelación del `Timer` para la limpieza de recursos.
- `Isolate` para ejecutar tareas pesadas sin bloquear la interfaz.
- Comunicación de resultados mediante mensajes.

## Estructura del repositorio

```text
flutter-talleres/
│
├── README.md
│
├── taller1/
│   ├── android/
│   ├── assets/
│   ├── lib/
│   ├── test/
│   ├── web/
│   ├── pubspec.yaml
│   └── ...
│
└── taller_segundo_plano/
    ├── android/
    ├── ios/
    ├── lib/
    ├── test/
    ├── web/
    ├── windows/
    ├── pubspec.yaml
    └── ...
