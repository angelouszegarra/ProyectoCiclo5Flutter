// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/producto_database.dart';
import '../models/producto.dart';
import '../providers/app_state.dart';
import '../widgets/base_scaffold.dart'; // Asegúrate de crear este widget como te expliqué
import './plan_detalle_page.dart';

class PlanesPage extends StatefulWidget {
  const PlanesPage({super.key});

  @override
  State<PlanesPage> createState() => _PlanesPageState();
}

class _PlanesPageState extends State<PlanesPage> {
  List<Producto> planes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarPlanes();
  }

  Future<void> _cargarPlanes() async {
    final db = ProductoDatabase();
    final planesCargados = await db.getProductosPorCategoria('plan');
    setState(() {
      planes = planesCargados;
      isLoading = false;
    });
  }

  Future<void> _mostrarDetallesPlan(BuildContext context, Producto plan) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanDetallePage(plan: plan),
      ),
    );

    if (resultado == true) {
      final appState = Provider.of<AppState>(context, listen: false);

      // Agregar al carrito usando AppState
      appState.agregarAlCarrito(plan);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${plan.nombre} agregado al carrito'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).size.height - 100,
          ),
        ),
      );

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('¿Qué deseas hacer?'),
          content: const Text(
              '¿Quieres agregar plantas para tu instalación o ir directamente al carrito?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/plantas');
              },
              child: const Text('Agregar plantas'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/carrito');
              },
              child: const Text('Ir al carrito'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Nuestros Planes',
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Elige el plan perfecto para tu jardín',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                      itemCount: planes.length,
                      itemBuilder: (context, index) {
                        final plan = planes[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  plan.nombre,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  plan.descripcion,
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'S/. ${plan.precio.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4CAF50),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => _mostrarDetallesPlan(context, plan),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4CAF50),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Ver Detalles',
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
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
