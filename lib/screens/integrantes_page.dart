import 'package:flutter/material.dart';

class IntegrantesPage extends StatelessWidget {
  const IntegrantesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final integrantes = [
      {
        'nombre': 'Ana Pérez',
        'imagen': 'assets/images/ana.jpg',
        'descripcion':
            'Ingeniera ambiental. Apasionada por la jardinería y la tecnología.',
      },
      {
        'nombre': 'Carlos López',
        'imagen': 'assets/images/carlos.jpg',
        'descripcion':
            'Desarrollador de software. Encargado de la plataforma digital.',
      },
      {
        'nombre': 'María Ruiz',
        'imagen': 'assets/images/maria.jpg',
        'descripcion':
            'Diseñadora de interiores. Especialista en paisajismo urbano.',
      },
      {
        'nombre': 'José García',
        'imagen': 'assets/images/jose.jpg',
        'descripcion':
            'Técnico en instalaciones. Experto en sistemas de riego.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrantes'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: integrantes.length,
        itemBuilder: (context, index) {
          final integrante = integrantes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(integrante['imagen']!),
                    onBackgroundImageError: (_, __) => const Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    integrante['nombre']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    integrante['descripcion']!,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
