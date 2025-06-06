import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/usuario.dart';
import '../providers/app_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el usuario desde el estado global
    final appState = Provider.of<AppState>(context);
    final Usuario? usuario = appState.usuario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AquaGarden'),
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
            const SizedBox(), // O puedes mostrar un botón de login
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
            Text(
              'Bienvenido a AquaGarden${usuario != null ? ', ${usuario.nombre}' : ''}',
              style: const TextStyle(
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
    final appState = Provider.of<AppState>(context, listen: false);

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
            // Limpiar usuario en el estado global y navegar a auth
            appState.limpiarUsuario();
            Navigator.pushReplacementNamed(context, '/auth');
            break;
        }
      },
    );
  }
}
