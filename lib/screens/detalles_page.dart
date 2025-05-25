import 'package:flutter/material.dart';

class DetallesPage extends StatelessWidget {
  const DetallesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de implementación'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Cómo implementamos el sistema de riego?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '1. Medición del área',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Nuestro equipo visita tu hogar para medir el espacio donde se instalará el sistema. Evaluamos el tipo de suelo, la disponibilidad de agua y la cantidad de plantas.',
            ),
            const SizedBox(height: 16),
            const Text(
              '2. Diseño personalizado',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Creamos un diseño a medida, eligiendo los aspersores y sensores adecuados para cada zona de tu jardín o terraza.',
            ),
            const SizedBox(height: 16),
            const Text(
              '3. Instalación profesional',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Nuestros técnicos instalan el sistema de manera limpia y eficiente, asegurando que funcione correctamente y se integre estéticamente con tu espacio.',
            ),
            const SizedBox(height: 16),
            const Text(
              '¿Quiénes usan el sistema y en qué situaciones?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- Familias con poco tiempo para el cuidado del jardín.\n'
              '- Personas que viajan frecuentemente.\n'
              '- Oficinas y espacios públicos que requieren riego automático.\n'
              '- Amantes de la jardinería que buscan optimizar el crecimiento de sus plantas.',
            ),
            const SizedBox(height: 16),
            const Text(
              '¡El sistema se adapta a cada situación y necesidad!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
