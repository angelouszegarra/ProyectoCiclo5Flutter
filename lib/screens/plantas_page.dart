// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../db/producto_database.dart';
import '../models/producto.dart';

class PlantasPage extends StatefulWidget {
  const PlantasPage({super.key});

  @override
  State<PlantasPage> createState() => _PlantasPageState();
}

class _PlantasPageState extends State<PlantasPage> {
  List<Producto> plantas = [];
  bool isLoading = true;
  String filtroSeleccionado = 'General';

  final List<String> filtros = [
    'General',
    'Plantas internas',
    'Árboles',
    'Frutas',
    'Verduras',
  ];

  // Mapa para relacionar los nombres de los filtros con las subcategorías de la base de datos
  final Map<String, String> filtroMap = {
    'Plantas internas': 'interior',
    'Árboles': 'árboles',
    'Frutas': 'frutas',
    'Verduras': 'verduras',
  };

  @override
  void initState() {
    super.initState();
    _cargarPlantas();
  }

  Future<void> _cargarPlantas() async {
    final db = ProductoDatabase();
    final plantasCargadas = await db.getProductosPorCategoria('planta');
    if (kDebugMode) {
      print('Plantas cargadas: ${plantasCargadas.length}');
    }
    setState(() {
      plantas = plantasCargadas;
      isLoading = false;
    });
  }


  List<Producto> _filtrarPlantas() {
    if (filtroSeleccionado == 'General') return plantas;
    // Usa el mapa para obtener la subcategoría correcta
    final subcat = filtroMap[filtroSeleccionado] ?? filtroSeleccionado.toLowerCase();
    return plantas
        .where((p) => p.subcategoria.toLowerCase().contains(subcat))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plantas y Semillas'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/carrito'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de filtros
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filtros
                  .map(
                    (filtro) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilterChip(
                        label: Text(filtro),
                        selected: filtroSeleccionado == filtro,
                        onSelected: (selected) {
                          setState(() {
                            filtroSeleccionado = filtro;
                          });
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          isLoading
              ? const Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _filtrarPlantas().length,
                    itemBuilder: (context, index) {
                      final planta = _filtrarPlantas()[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16)),
                                child: Image.asset(
                                  planta.imagen,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 50),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    planta.nombre,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    planta.descripcion,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'S/. ${planta.precio.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4CAF50),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_shopping_cart),
                                        color: const Color(0xFF4CAF50),
                                        onPressed: () async {
                                          final db = ProductoDatabase();
                                          await db.agregarAlCarrito(planta.id!, 1);
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('${planta.nombre} agregado'),
                                              behavior: SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(
                                                top: 10,
                                                right: 10,
                                                bottom: MediaQuery.of(context).size.height - 100,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
