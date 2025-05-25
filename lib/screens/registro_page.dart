// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../db/producto_database.dart';
// ignore: unused_import
import '../models/producto.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _dniController = TextEditingController();
  final _distritoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de Instalación'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre Completo',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese su nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dniController,
                decoration: const InputDecoration(
                  labelText: 'DNI',
                  prefixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.length != 8 ? 'DNI debe tener 8 dígitos' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _distritoController,
                decoration: const InputDecoration(
                  labelText: 'Distrito',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el distrito' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(
                  labelText: 'Dirección de Instalación',
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese la dirección' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono (Opcional)',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final db = ProductoDatabase();
                    
                    // Registrar cliente
                    await db.registrarCliente(
                      nombre: _nombreController.text,
                      dni: _dniController.text,
                      distrito: _distritoController.text,
                      direccionInstalacion: _direccionController.text,
                      telefono: _telefonoController.text.isNotEmpty
                          ? _telefonoController.text
                          : null,
                    );

                    // Limpiar carrito
                    await db.limpiarCarrito();

                    if (!mounted) return;
                    
                    Navigator.pushReplacementNamed(context, '/');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('¡Instalación programada con éxito!'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Finalizar Compra',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
