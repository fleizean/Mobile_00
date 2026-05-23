import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '0';
  bool _justCalculated = false;

  static const List<String> _buttons = [
    '7', '8', '9', 'C', 'AC',
    '4', '5', '6', '+', '-',
    '1', '2', '3', '*', '/',
    '0', '00', '.', '=', '',
  ];

  void _onButton(String label) {
    debugPrint('button pressed :$label');
    setState(() {
      switch (label) {
        case 'AC':
          _expression = '';
          _result = '0';
          _justCalculated = false;
        case 'C':
          if (_expression.isNotEmpty) {
            _expression = _expression.substring(0, _expression.length - 1);
          }
        case '=':
          _result = _evaluate(_expression);
          _justCalculated = true;
        default:
          if (_justCalculated) {
            final isOperator = ['+', '-', '*', '/'].contains(label);
            _expression = isOperator ? _result + label : label;
            _justCalculated = false;
          } else {
            _expression += label;
          }
      }
    });
  }

  String _evaluate(String expr) {
    if (expr.isEmpty) return '0';
    try {
      final parser = GrammarParser();
      final exp = parser.parse(expr);
      final cm = ContextModel();
      final result = exp.evaluate(EvaluationType.REAL, cm) as double;

      if (result.isNaN || result.isInfinite) return 'Error';
      if (result == result.truncateToDouble()) {
        return result.toInt().toString();
      }
      return result.toString();
    } catch (_) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: const Color(0xFF1E1E2C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF1E1E2C),
      body: Column(
        children: [
          Expanded(flex: 2, child: _buildDisplay()),
          Expanded(flex: 5, child: _buildButtonGrid()),
        ],
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              _expression.isEmpty ? '0' : _expression,
              style: const TextStyle(color: Colors.white54, fontSize: 20),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              _result,
              style: TextStyle(
                color: _result == 'Error' ? Colors.redAccent : Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonGrid() {
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
          onPressed: () => _onButton(label),
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
    if (label == 'AC') return const Color(0xFFD62828);
    if (label == 'C')  return const Color(0xFFE9A820);
    if (label == '=')  return const Color(0xFF0096B4);
    if (['+', '-', '*', '/'].contains(label)) return const Color(0xFF3D3580);
    return const Color(0xFF2D2D44);
  }

  Color _fgColor() {
    if (label == 'C') return Colors.black87;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _bgColor(),
        foregroundColor: _fgColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.zero,
        elevation: 0,
      ),
      child: FittedBox(
        child: Text(label, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
