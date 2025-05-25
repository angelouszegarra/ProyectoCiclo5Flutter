import 'package:flutter/material.dart';
import '../db/producto_database.dart';
import '../models/producto.dart';
import './plan_detalle_page.dart'; // Asegúrate de que este archivo existe

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
    print('Iniciando carga de planes'); // <-- Añade esto
    final db = ProductoDatabase();
    final planesCargados = await db.getProductosPorCategoria('plan');
    print('Planes cargados: $planesCargados'); // <-- Ya lo tienes
    setState(() {
      planes = planesCargados;
      isLoading = false;
    });
  }



  Future<void> _mostrarDetallesPlan(BuildContext context, Producto plan) async {
    // Navega a la pantalla de detalles del plan
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanDetallePage(plan: plan),
      ),
    );

    // Si el usuario seleccionó el plan desde la pantalla de detalles,
    // procede a agregarlo al carrito y mostrar el cuadro de opciones
    if (resultado == true) {
      final db = ProductoDatabase();
      await db.agregarAlCarrito(plan.id!, 1);

      if (!mounted) return;

      // Snackbar arriba a la derecha
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

      // Diálogo para elegir: agregar plantas o ir al carrito
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuestros Planes'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
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
