import 'package:flutter/material.dart';

class CompraPage extends StatefulWidget {
  final bool soloSemillas;

  const CompraPage({super.key, required this.soloSemillas});

  @override
  State<CompraPage> createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _celularController = TextEditingController();
  final _distritoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar Compra'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (!widget.soloSemillas) ...[
                const Text(
                  '¡Gracias por elegir nuestro plan!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre completo',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su nombre' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _celularController,
                  decoration: const InputDecoration(
                    labelText: 'Número de celular',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su celular' : null,
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
                const SizedBox(height: 24),
                const Text(
                  'Nos contactaremos contigo para coordinar la instalación.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                const Text(
                  '¡Gracias por tu compra!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Agradecemos tu preferencia. Esperamos que disfrutes tus semillas.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (!widget.soloSemillas && _formKey.currentState!.validate()) {
                    // Guardar datos y mostrar mensaje de éxito
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Datos guardados. Nos contactaremos pronto.'),
                      ),
                    );
                  } else if (widget.soloSemillas) {
                    // Solo semillas, mensaje de agradecimiento
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('¡Gracias por tu compra!'),
                      ),
                    );
                  }
                  // Puedes regresar al inicio o a la página principal
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  'Finalizar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
