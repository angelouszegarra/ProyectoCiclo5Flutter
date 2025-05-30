// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:laboratorio_10/screens/home_page.dart';
import 'screens/auth_page.dart';
import 'screens/planes_page.dart';
import 'screens/plantas_page.dart';
import 'screens/info_page.dart';
import 'screens/integrantes_page.dart';
import 'screens/detalles_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';

void main() {
  if (!kIsWeb) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaGarden',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthPage(),
        // Ahora HomePage no recibe usuario por parámetro, lo obtiene desde AppState
        '/home': (context) => const HomePage(),
        '/planes': (context) => const PlanesPage(),
        '/plantas': (context) => const PlantasPage(),
        '/info': (context) => const InfoPage(),
        '/integrantes': (context) => const IntegrantesPage(),
        '/detalles': (context) => const DetallesPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }
}
