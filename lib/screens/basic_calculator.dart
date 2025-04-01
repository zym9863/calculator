import 'package:flutter/material.dart';
import '../services/calculator_service.dart';

class BasicCalculator extends StatefulWidget {
  final Function(String, String) onCalculation;

  const BasicCalculator({Key? key, required this.onCalculation}) : super(key: key);

  @override
  State<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  final CalculatorService _calculatorService = CalculatorService();
  String _input = '';
  String _result = '';
  bool _hasCalculated = false;

  // 按钮样式
  final ButtonStyle _numberButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[300],
    foregroundColor: Colors.black,
    padding: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  final ButtonStyle _operatorButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  final ButtonStyle _functionButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[700],
    foregroundColor: Colors.white,
    padding: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (_hasCalculated && !isOperator(buttonText)) {
        _input = '';
        _hasCalculated = false;
      }

      switch (buttonText) {
        case 'C':
          _input = '';
          _result = '';
          break;
        case '⌫':
          if (_input.isNotEmpty) {
            _input = _input.substring(0, _input.length - 1);
          }
          break;
        case '=':
          if (_input.isNotEmpty) {
            _result = _calculatorService.calculate(_input);
            widget.onCalculation(_input, _result);
            _hasCalculated = true;
          }
          break;
        default:
          if (_hasCalculated && isOperator(buttonText)) {
            _input = _result + buttonText;
            _hasCalculated = false;
          } else {
            _input += buttonText;
          }
          break;
      }
    });
  }

  bool isOperator(String text) {
    return text == '+' || text == '-' || text == '×' || text == '÷';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 显示区域
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _input,
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              Text(
                _result,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        // 按钮区域
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                buildButtonRow(['C', '⌫', '%', '÷']),
                buildButtonRow(['7', '8', '9', '×']),
                buildButtonRow(['4', '5', '6', '-']),
                buildButtonRow(['1', '2', '3', '+']),
                buildButtonRow(['0', '.', '(', ')']),
                buildEqualButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((buttonText) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () => _onButtonPressed(buttonText),
                style: isOperator(buttonText)
                    ? _operatorButtonStyle
                    : (buttonText == 'C' || buttonText == '⌫' || buttonText == '%')
                        ? _functionButtonStyle
                        : _numberButtonStyle,
                child: Text(
                  buttonText,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildEqualButton() {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 60,
      child: ElevatedButton(
        onPressed: () => _onButtonPressed('='),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Center(
          child: Text(
            '=',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}