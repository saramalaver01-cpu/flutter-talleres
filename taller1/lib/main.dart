import 'package:flutter/material.dart';

void main() {
  runApp(const Taller1App());
}

// ============================================================
// APLICACIÓN PRINCIPAL
// ============================================================

class Taller1App extends StatelessWidget {
  const Taller1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller 1 - Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================
// HOME PAGE - STATEFUL WIDGET
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ==========================================================
  // VARIABLE DE ESTADO
  // ==========================================================

  String titulo = 'Hola, Flutter';

  // ==========================================================
  // CAMBIAR TÍTULO
  // ==========================================================

  void cambiarTitulo() {
    setState(() {
      if (titulo == 'Hola, Flutter') {
        titulo = '¡Título cambiado!';
      } else {
        titulo = 'Hola, Flutter';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Título actualizado'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ==========================================================
  // SEGUNDO BOTÓN
  // ==========================================================

  void mostrarMensaje() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Botón funcionando correctamente!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ==========================================================
  // INTERFAZ
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(title: Text(titulo), centerTitle: true),

      // ========================================================
      // CUERPO
      // ========================================================
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // ==================================================
              // NOMBRE DEL ESTUDIANTE
              // ==================================================

              const Text(
                'SARA MILENA MALAVER OSPINA - 230232010',
                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text('Taller 1 - Flutter', style: TextStyle(fontSize: 18)),

              const SizedBox(height: 25),

              // ==================================================
              // IMÁGENES
              // Row + Image.network + Image.asset
              // ==================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  // ------------------------------------------------
                  // IMAGE.NETWORK
                  // ------------------------------------------------

                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: Image.network(
                      'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a1e6f4e4c7f2f.png',

                      width: 130,
                      height: 130,

                      fit: BoxFit.contain,

                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 130,
                          height: 130,

                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: const Icon(
                            Icons.code_rounded,
                            size: 65,
                            color: Colors.blue,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 25),

                  // ------------------------------------------------
                  // IMAGE.ASSET
                  // ------------------------------------------------
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: Image.asset(
                      'assets/images/flutter.png',

                      width: 130,
                      height: 130,

                      fit: BoxFit.contain,

                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 130,
                          height: 130,

                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: const Icon(
                            Icons.image_outlined,
                            size: 65,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ==================================================
              // CONTAINER
              // ==================================================
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,

                  borderRadius: BorderRadius.circular(15),

                  border: Border.all(color: Colors.blue, width: 2),
                ),

                child: const Column(
                  children: [
                    // Ícono minimalista
                    Icon(Icons.code_rounded, size: 45),

                    SizedBox(height: 10),

                    Text(
                      'Widget Container',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Este elemento demuestra el uso '
                      'del widget Container.',

                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // LISTVIEW
              // ==================================================
              const Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'Widgets utilizados',

                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 210,

                child: ListView(
                  children: const [
                    // --------------------------------------------
                    // ELEMENTO 1
                    // --------------------------------------------

                    ListTile(
                      leading: Icon(Icons.code_rounded),

                      title: Text('Flutter'),

                      subtitle: Text(
                        'Framework utilizado para '
                        'desarrollar la aplicación.',
                      ),
                    ),

                    // --------------------------------------------
                    // ELEMENTO 2
                    // --------------------------------------------
                    ListTile(
                      leading: Icon(Icons.widgets_outlined),

                      title: Text('Widgets'),

                      subtitle: Text(
                        'Elementos utilizados para '
                        'crear la interfaz.',
                      ),
                    ),

                    // --------------------------------------------
                    // ELEMENTO 3
                    // --------------------------------------------
                    ListTile(
                      leading: Icon(Icons.refresh_rounded),

                      title: Text('StatefulWidget'),

                      subtitle: Text('Permite manejar cambios de estado.'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // BOTÓN PRINCIPAL
              // ==================================================
              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: cambiarTitulo,

                  icon: const Icon(Icons.edit_rounded),

                  label: const Text('Cambiar título'),

                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ==================================================
              // SEGUNDO BOTÓN
              // ==================================================
              SizedBox(
                width: double.infinity,

                child: OutlinedButton.icon(
                  onPressed: mostrarMensaje,

                  icon: const Icon(Icons.touch_app_rounded),

                  label: const Text('Probar botón'),

                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // EXPLICACIÓN DE SETSTATE
              // ==================================================
              const Text(
                'El botón "Cambiar título" utiliza '
                'setState() para actualizar la variable '
                'titulo y modificar el título del AppBar.',

                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
