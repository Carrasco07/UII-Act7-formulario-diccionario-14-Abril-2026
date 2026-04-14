import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.business_center,
                size: 120,
                color: Colors.indigo,
              ),
              const SizedBox(height: 20),
              const Text(
                'Gestor de Empleados',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton.icon(
                icon: const Icon(Icons.person_add, size: 28),
                label: const Text('Capturar Empleados', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  elevation: 5,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/captura');
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                icon: const Icon(Icons.people, size: 28),
                label: const Text('Ver Empleados', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  elevation: 5,
                  side: const BorderSide(color: Colors.indigo, width: 2),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/ver');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
