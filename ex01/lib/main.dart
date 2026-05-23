import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HelloWorldPage(),
    );
  }
}

class HelloWorldPage extends StatefulWidget {
  const HelloWorldPage({super.key});

  @override
  State<HelloWorldPage> createState() => _HelloWorldPageState();
}

class _HelloWorldPageState extends State<HelloWorldPage> {
  static const String _initialText = 'A simple text';
  bool _showHello = false;

  void _onButtonPressed() {
    setState(() {
      _showHello = !_showHello;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_showHello ? 'Hello World!' : _initialText),
            ElevatedButton(
              onPressed: _onButtonPressed,
              child: const Text('Click me'),
            ),
          ],
        ),
      ),
    );
  }
}
