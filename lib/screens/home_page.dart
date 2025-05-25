import 'package:flutter/material.dart';
import '../models/usuario.dart';


class HomePage extends StatelessWidget {
  final Usuario usuario;

  const HomePage({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AquaGarden'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        actions: [
          _UserProfileButton(usuario: usuario),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50),
              ),
              child: Text(
                'AquaGarden',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.local_florist, color: Color(0xFF4CAF50)),
              title: const Text('Planes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/planes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.eco, color: Color(0xFF4CAF50)),
              title: const Text('Plantas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/plantas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Color(0xFF4CAF50)),
              title: const Text('Información'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/info');
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Color(0xFF4CAF50)),
              title: const Text('Integrantes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/integrantes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list, color: Color(0xFF4CAF50)),
              title: const Text('Detalles'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/detalles');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.water_drop,
              size: 120,
              color: Colors.green[300],
            ),
            const SizedBox(height: 20),
            const Text(
              'Bienvenido a AquaGarden',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserProfileButton extends StatefulWidget {
  final Usuario usuario;

  const _UserProfileButton({required this.usuario});

  @override
  State<_UserProfileButton> createState() => _UserProfileButtonState();
}

class _UserProfileButtonState extends State<_UserProfileButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Row(
        children: [
          CircleAvatar(
            backgroundImage: widget.usuario.avatar != null
                ? AssetImage(widget.usuario.avatar!)
                : const AssetImage('assets/images/avatar_default.png'),
            child: widget.usuario.avatar == null
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            widget.usuario.nombre,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'cambiar_foto',
          child: Text('Cambiar foto'),
        ),
        const PopupMenuItem(
          value: 'cambiar_nombre',
          child: Text('Cambiar nombre'),
        ),
        const PopupMenuItem(
          value: 'cambiar_contrasena',
          child: Text('Cambiar contraseña'),
        ),
        const PopupMenuItem(
          value: 'cerrar_sesion',
          child: Text('Cerrar sesión'),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'cambiar_foto':
            // Lógica para cambiar foto
            break;
          case 'cambiar_nombre':
            // Lógica para cambiar nombre
            break;
          case 'cambiar_contrasena':
            // Lógica para cambiar contraseña
            break;
          case 'cerrar_sesion':
            // Lógica para cerrar sesión
            Navigator.pushReplacementNamed(context, '/auth');
            break;
        }
      },
    );
  }
}
