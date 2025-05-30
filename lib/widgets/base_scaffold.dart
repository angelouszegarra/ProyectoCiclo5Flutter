import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/usuario.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const BaseScaffold({required this.body, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final Usuario? usuario = appState.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/carrito');
            },
          ),
          if (usuario != null)
            _UserProfileButton(usuario: usuario)
          else
            const SizedBox(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF4CAF50)),
              child: Text(
                'AquaGarden',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.local_florist, color: Color(0xFF4CAF50)),
              title: const Text('Planes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/planes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.eco, color: Color(0xFF4CAF50)),
              title: const Text('Plantas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/plantas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Color(0xFF4CAF50)),
              title: const Text('Información'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/info');
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Color(0xFF4CAF50)),
              title: const Text('Integrantes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/integrantes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list, color: Color(0xFF4CAF50)),
              title: const Text('Detalles'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/detalles');
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}

class _UserProfileButton extends StatelessWidget {
  final Usuario usuario;

  const _UserProfileButton({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return PopupMenuButton(
      icon: Row(
        children: [
          CircleAvatar(
            backgroundImage: usuario.avatar != null
                ? AssetImage(usuario.avatar!)
                : const AssetImage('assets/images/avatar_default.png'),
            child: usuario.avatar == null
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            usuario.nombre,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'cambiar_foto', child: Text('Cambiar foto')),
        const PopupMenuItem(value: 'cambiar_nombre', child: Text('Cambiar nombre')),
        const PopupMenuItem(value: 'cambiar_contrasena', child: Text('Cambiar contraseña')),
        const PopupMenuItem(value: 'cerrar_sesion', child: Text('Cerrar sesión')),
      ],
      onSelected: (value) {
        switch (value) {
          case 'cerrar_sesion':
            appState.limpiarUsuario();
            Navigator.pushReplacementNamed(context, '/auth');
            break;
          // Agrega lógica para los otros casos si quieres
        }
      },
    );
  }
}
