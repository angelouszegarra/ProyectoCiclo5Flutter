import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../widgets/base_scaffold.dart';

class PlanDetallePage extends StatelessWidget {
  final Producto plan;

  const PlanDetallePage({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: plan.nombre,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                plan.imagen,
                width: 200,
                height: 200,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 100),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              plan.nombre,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'S/. ${plan.precio.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '¿Qué incluye el plan básico?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '- Instalación profesional del sistema de riego automático.\n'
              '- Configuración inicial y ajustes personalizados.\n'
              '- Soporte técnico durante 1 mes.\n'
              '- Manual de usuario y recomendaciones de mantenimiento.\n'
              '- Asesoría para selección de plantas adecuadas.\n',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Aquí puedes agregar lógica para agregar al carrito o pedir más info
                  Navigator.pop(context);
                },
                child: const Text(
                  'Seleccionar Plan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
