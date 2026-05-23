import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  static const List<String> _buttons = [
    '7', '8', '9', 'C', 'AC',
    '4', '5', '6', '+', '-',
    '1', '2', '3', '*', '/',
    '0', '00', '.', '=', '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blueGrey.shade700,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.blueGrey.shade800,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: _buildDisplay(),
          ),
          Expanded(
            flex: 5,
            child: _buildButtonGrid(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            readOnly: true,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(border: InputBorder.none),
            style: const TextStyle(color: Colors.white70, fontSize: 20),
            controller: TextEditingController(text: '0'),
          ),
          TextField(
            readOnly: true,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(border: InputBorder.none),
            style: const TextStyle(color: Colors.white, fontSize: 32),
            controller: TextEditingController(text: '0'),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _buttons.length,
      itemBuilder: (context, index) {
        final label = _buttons[index];
        if (label.isEmpty) return const SizedBox.shrink();
        return _CalcButton(
          label: label,
          onPressed: () => debugPrint('button pressed :$label'),
        );
      },
    );
  }
}

class _CalcButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _CalcButton({required this.label, required this.onPressed});

  Color _bgColor() {
    if (label == 'AC') return Colors.red.shade700;
    if (label == 'C') return Colors.red.shade400;
    if (label == '=') return Colors.orange.shade700;
    if (['+', '-', '*', '/'].contains(label)) return Colors.blueGrey.shade500;
    return Colors.blueGrey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _bgColor(),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.zero,
      ),
      child: FittedBox(
        child: Text(label, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
