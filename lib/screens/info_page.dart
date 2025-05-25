import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Soluciones modernas para tu hogar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'En AquaGarden ofrecemos soluciones innovadoras de riego automatizado adaptadas a las necesidades actuales. Utilizamos tecnología inteligente para mantener tus plantas saludables sin esfuerzo.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '¿Qué plantas son ideales para cada espacio?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 8),
            _buildPlantInfo('Salón', 'Plantas de interior como el Pothos, Sansevieria o Ficus.'),
            _buildPlantInfo('Cocina', 'Hierbas aromáticas como albahaca, menta o romero.'),
            _buildPlantInfo('Jardín', 'Frutales como tomate o fresa, y árboles ornamentales.'),
            _buildPlantInfo('Balcón', 'Plantas resistentes al sol como geranios, suculentas o cactus.'),
            _buildPlantInfo('Baño', 'Plantas que prefieren humedad como helechos o calatheas.'),
            const SizedBox(height: 16),
            const Text(
              '¡Personaliza tu sistema de riego según el espacio y tipo de planta!',
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

  Widget _buildPlantInfo(String espacio, String plantas) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            espacio,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(plantas),
        ],
      ),
    );
  }
}
