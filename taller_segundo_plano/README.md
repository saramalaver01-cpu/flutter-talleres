# Taller 2 - Procesos en Segundo Plano con Flutter

## Descripción

Este proyecto corresponde al Taller 2 de la asignatura y tiene como objetivo demostrar el funcionamiento de diferentes mecanismos de ejecución asíncrona y procesos en segundo plano en Flutter.

La aplicación implementa tres funcionalidades principales:

- Future y async/await.
- Timer mediante un cronómetro.
- Isolate para ejecutar un proceso pesado sin bloquear la interfaz.

---

# Objetivos

## Objetivo general

Desarrollar una aplicación en Flutter que permita comprender y demostrar el funcionamiento de Future, async/await, Timer e Isolate mediante ejemplos prácticos e interactivos.

## Objetivos específicos

- Implementar una operación asíncrona utilizando Future.
- Utilizar async/await para controlar el flujo de una operación que tarda varios segundos.
- Mostrar estados de carga, éxito y error en la interfaz.
- Implementar un cronómetro utilizando Timer.periodic().
- Permitir iniciar, pausar, reanudar y reiniciar el cronómetro.
- Cancelar correctamente el Timer cuando ya no sea necesario.
- Ejecutar un proceso de alto consumo computacional mediante Isolate.
- Utilizar SendPort y ReceivePort para comunicar el Isolate con la aplicación principal.
- Mostrar en pantalla el resultado y el tiempo de ejecución del proceso pesado.

---

# Tecnologías utilizadas

- Flutter
- Dart
- Future
- async/await
- Future.delayed()
- Timer
- Timer.periodic()
- Isolate
- Isolate.spawn()
- SendPort
- ReceivePort
- StatefulWidget
- setState()

---

# Funcionalidades

## 1. Future + async/await

La primera sección de la aplicación simula una consulta a un servicio.

La operación utiliza:

```dart
Future.delayed()