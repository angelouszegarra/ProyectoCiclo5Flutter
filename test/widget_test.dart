// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:laboratorio_10/main.dart';
import 'package:laboratorio_10/models/usuario.dart';
import 'package:laboratorio_10/screens/home_page.dart';

void main() {
  testWidgets('HomePage smoke test', (WidgetTester tester) async {
    // Construye la app con HomePage
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Verifica que el título principal esté presente
    expect(find.text('AquaGarden'), findsOneWidget);
    expect(find.text('Regadoras Automáticas'), findsOneWidget);

    // Verifica que el botón de "Comenzar" esté presente
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Comenzar'), findsOneWidget);
  });
}
