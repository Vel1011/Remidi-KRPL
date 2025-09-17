// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project_4/main.dart';

void main() {
  testWidgets('App loads and shows Daftar Siswa text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our AppBar shows "Daftar Siswa".
    expect(find.text('Daftar Siswa'), findsOneWidget);

    // Verify that the add button (FAB) exists.
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Tap FAB opens student form page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that our form page opened.
    expect(find.text('Tambah Siswa'), findsOneWidget);
    expect(find.byType(TextFormField), findsWidgets);
  });
}