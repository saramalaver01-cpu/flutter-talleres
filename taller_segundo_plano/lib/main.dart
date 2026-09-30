import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

void main() {
  runApp(const TallerSegundoPlanoApp());
}

class TallerSegundoPlanoApp extends StatelessWidget {
  const TallerSegundoPlanoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller Segundo Plano',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ================================================================
// FUNCIÓN PARA EL ISOLATE
// ================================================================
//
// Esta función se ejecuta fuera del hilo principal.
// Realiza un cálculo pesado y envía el resultado mediante SendPort.
//

void procesoPesado(SendPort sendPort) {
  const int limite = 50000000;

  int suma = 0;

  for (int i = 1; i <= limite; i++) {
    suma += i;
  }

  sendPort.send(suma);
}

// ================================================================
// HOME PAGE
// ================================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ==============================================================
  // FUTURE + ASYNC/AWAIT
  // ==============================================================

  String estado = 'Presiona el botón para consultar el servicio.';

  bool cargando = false;

  // Simulación de un servicio
  Future<String> consultarServicio() async {
    print('1. Antes de iniciar la consulta');

    await Future.delayed(const Duration(seconds: 3));

    print('2. Consulta finalizada');

    return 'Datos obtenidos correctamente del servicio.';
  }

  // Ejecutar la consulta
  Future<void> ejecutarConsulta() async {
    print('========================================');
    print('INICIO DE LA CONSULTA');
    print('========================================');

    setState(() {
      cargando = true;
      estado = 'Cargando...';
    });

    print('3. La interfaz muestra Cargando...');

    try {
      final resultado = await consultarServicio();

      if (!mounted) {
        return;
      }

      setState(() {
        estado = resultado;
        cargando = false;
      });

      print('4. Resultado mostrado en pantalla');
      print('Consulta completada correctamente.');
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        estado = 'Ocurrió un error al consultar el servicio.';
        cargando = false;
      });

      print('Error: $e');
    }

    print('--- FIN DE LA CONSULTA ---');
  }

  // ==============================================================
  // TIMER - CRONÓMETRO
  // ==============================================================

  Timer? timer;

  int segundos = 0;

  bool cronometroActivo = false;

  // Convertir segundos a MM:SS
  String obtenerTiempo() {
    final minutos = segundos ~/ 60;
    final segundosRestantes = segundos % 60;

    final minutosTexto = minutos.toString().padLeft(2, '0');

    final segundosTexto = segundosRestantes.toString().padLeft(2, '0');

    return '$minutosTexto:$segundosTexto';
  }

  // Iniciar cronómetro
  void iniciarCronometro() {
    if (cronometroActivo) {
      return;
    }

    print('Cronómetro iniciado');

    setState(() {
      cronometroActivo = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        segundos++;
      });

      print('Tiempo: ${obtenerTiempo()}');
    });
  }

  // Pausar cronómetro
  void pausarCronometro() {
    print('Cronómetro pausado');

    timer?.cancel();

    setState(() {
      cronometroActivo = false;
    });
  }

  // Reanudar cronómetro
  void reanudarCronometro() {
    if (cronometroActivo) {
      return;
    }

    print('Cronómetro reanudado');

    setState(() {
      cronometroActivo = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        segundos++;
      });

      print('Tiempo: ${obtenerTiempo()}');
    });
  }

  // Reiniciar cronómetro
  void reiniciarCronometro() {
    print('Cronómetro reiniciado');

    timer?.cancel();

    setState(() {
      segundos = 0;
      cronometroActivo = false;
    });
  }

  // ==============================================================
  // ISOLATE
  // ==============================================================

  bool procesoPesadoActivo = false;

  String resultadoIsolate = 'Presiona el botón para iniciar el proceso pesado.';

  String tiempoInicioIsolate = '';

  String tiempoFinIsolate = '';

  String duracionIsolate = '';

  // Ejecutar proceso pesado mediante Isolate
  Future<void> ejecutarProcesoIsolate() async {
    if (procesoPesadoActivo) {
      return;
    }

    print('');
    print('========================================');
    print('INICIO DEL PROCESO CON ISOLATE');
    print('========================================');

    final inicio = DateTime.now();

    if (!mounted) {
      return;
    }

    setState(() {
      procesoPesadoActivo = true;

      resultadoIsolate = 'Procesando 50.000.000 números...';

      tiempoInicioIsolate = inicio.toString();

      tiempoFinIsolate = '';

      duracionIsolate = '';
    });

    print('Hora de inicio: $inicio');

    print('Creando Isolate...');

    // Puerto para recibir el resultado
    final receivePort = ReceivePort();

    try {
      // Crear el Isolate
      await Isolate.spawn(procesoPesado, receivePort.sendPort);

      print('Isolate creado correctamente.');

      print('Esperando resultado...');

      // Recibir resultado enviado por el Isolate
      final resultado = await receivePort.first as int;

      final fin = DateTime.now();

      final duracion = fin.difference(inicio);

      print('Resultado recibido: $resultado');

      print('Hora de finalización: $fin');

      print('Duración: ${duracion.inMilliseconds} ms');

      print('PROCESO CON ISOLATE FINALIZADO');

      if (!mounted) {
        receivePort.close();
        return;
      }

      setState(() {
        procesoPesadoActivo = false;

        resultadoIsolate = 'Resultado: $resultado';

        tiempoFinIsolate = fin.toString();

        duracionIsolate = '${duracion.inMilliseconds} ms';
      });
    } catch (e) {
      print('Error en el Isolate: $e');

      if (!mounted) {
        receivePort.close();
        return;
      }

      setState(() {
        procesoPesadoActivo = false;

        resultadoIsolate = 'Ocurrió un error al ejecutar el proceso.';
      });
    } finally {
      receivePort.close();
    }
  }

  // ==============================================================
  // DISPOSE
  // ==============================================================

  @override
  void dispose() {
    // Cancelar Timer al salir de la pantalla
    timer?.cancel();

    super.dispose();
  }

  // ==============================================================
  // INTERFAZ
  // ==============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taller Segundo Plano'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // ====================================================
            // ENCABEZADO
            // ====================================================

            const Icon(
              Icons.developer_mode,
              size: 80,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 15),

            const Text(
              'Procesos Asíncronos en Flutter',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            const Text(
              'Demostración de Future, Timer e Isolate',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 35),

            // ====================================================
            // SECCIÓN 1 - FUTURE
            // ====================================================
            const Icon(Icons.cloud_sync, size: 70, color: Colors.deepPurple),

            const SizedBox(height: 15),

            const Text(
              '1. Future + async/await',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            const Text(
              'Se simula una consulta a un servicio '
              'que tarda 3 segundos en responder.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),

              child: Column(
                children: [
                  const Text(
                    'Estado de la consulta:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  if (cargando) const CircularProgressIndicator(),

                  if (cargando) const SizedBox(height: 15),

                  Text(
                    estado,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: cargando ? null : ejecutarConsulta,

                icon: const Icon(Icons.cloud_download),

                label: const Text('Consultar servicio'),
              ),
            ),

            const SizedBox(height: 35),

            const Divider(),

            const SizedBox(height: 30),

            // ====================================================
            // SECCIÓN 2 - TIMER
            // ====================================================
            const Icon(Icons.timer, size: 70, color: Colors.deepPurple),

            const SizedBox(height: 15),

            const Text(
              '2. Cronómetro con Timer',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            const Text(
              'El cronómetro se actualiza cada segundo '
              'utilizando Timer.periodic().',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),

              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),

              child: Column(
                children: [
                  const Text(
                    'Tiempo transcurrido',
                    style: TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    obtenerTiempo(),

                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    cronometroActivo
                        ? 'Cronómetro activo'
                        : 'Cronómetro pausado',

                    style: TextStyle(
                      fontSize: 16,
                      color: cronometroActivo ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // INICIAR
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: cronometroActivo ? null : iniciarCronometro,

                icon: const Icon(Icons.play_arrow),

                label: const Text('Iniciar'),
              ),
            ),

            const SizedBox(height: 10),

            // PAUSAR
            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: cronometroActivo ? pausarCronometro : null,

                icon: const Icon(Icons.pause),

                label: const Text('Pausar'),
              ),
            ),

            const SizedBox(height: 10),

            // REANUDAR
            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: cronometroActivo ? null : reanudarCronometro,

                icon: const Icon(Icons.play_circle),

                label: const Text('Reanudar'),
              ),
            ),

            const SizedBox(height: 10),

            // REINICIAR
            SizedBox(
              width: double.infinity,

              child: TextButton.icon(
                onPressed: reiniciarCronometro,

                icon: const Icon(Icons.restart_alt),

                label: const Text('Reiniciar'),
              ),
            ),

            const SizedBox(height: 35),

            const Divider(),

            const SizedBox(height: 30),

            // ====================================================
            // SECCIÓN 3 - ISOLATE
            // ====================================================
            const Icon(Icons.memory, size: 70, color: Colors.deepPurple),

            const SizedBox(height: 15),

            const Text(
              '3. Proceso pesado con Isolate',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            const Text(
              'Se ejecuta un cálculo de gran tamaño '
              'en un Isolate para evitar bloquear '
              'la interfaz principal.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),

              child: Column(
                children: [
                  const Text(
                    'Estado del proceso:',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  if (procesoPesadoActivo) const CircularProgressIndicator(),

                  if (procesoPesadoActivo) const SizedBox(height: 15),

                  Text(
                    resultadoIsolate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  if (tiempoInicioIsolate.isNotEmpty)
                    Text(
                      'Inicio:\n'
                      '$tiempoInicioIsolate',
                      textAlign: TextAlign.center,
                    ),

                  const SizedBox(height: 10),

                  if (tiempoFinIsolate.isNotEmpty)
                    Text(
                      'Finalización:\n'
                      '$tiempoFinIsolate',
                      textAlign: TextAlign.center,
                    ),

                  const SizedBox(height: 10),

                  if (duracionIsolate.isNotEmpty)
                    Text(
                      'Duración: '
                      '$duracionIsolate',

                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: procesoPesadoActivo ? null : ejecutarProcesoIsolate,

                icon: const Icon(Icons.memory),

                label: const Text('Ejecutar proceso pesado'),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              '¿Cómo funciona el Isolate?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Isolate.spawn() crea un proceso independiente '
              'para ejecutar el cálculo pesado. '
              'El resultado se envía a la aplicación mediante '
              'SendPort y ReceivePort.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 30),

            // ====================================================
            // RESUMEN
            // ====================================================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),

                border: Border.all(color: Colors.deepPurple.shade200),
              ),

              child: const Column(
                children: [
                  Text(
                    'Tecnologías utilizadas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 15),

                  Text(
                    '• Future\n'
                    '• async / await\n'
                    '• Future.delayed()\n'
                    '• Timer.periodic()\n'
                    '• Timer.cancel()\n'
                    '• Isolate.spawn()\n'
                    '• SendPort\n'
                    '• ReceivePort\n'
                    '• setState()',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
