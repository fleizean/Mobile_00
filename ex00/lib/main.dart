import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BasicDisplayPage(),
    );
  }
}

class BasicDisplayPage extends StatelessWidget {
  const BasicDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('A simple text'),
            ElevatedButton(
              onPressed: () {
                debugPrint('Button pressed');
              },
              child: const Text('Click me'),
            ),
          ],
        ),
      ),
    );
  }
}
