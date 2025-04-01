import 'package:flutter/material.dart';
import '../services/calculator_service.dart';

class ScientificCalculator extends StatefulWidget {
  final Function(String, String) onCalculation;

  const ScientificCalculator({Key? key, required this.onCalculation}) : super(key: key);

  @override
  State<ScientificCalculator> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  final CalculatorService _calculatorService = CalculatorService();
  String _input = '';
  String _result = '';
  bool _hasCalculated = false;
  bool _isRadMode = false; // 角度模式切换

  // 按钮样式 - 极简扁平化设计
  final ButtonStyle _numberButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[200],
    foregroundColor: Colors.black87,
    padding: const EdgeInsets.all(12),
    elevation: 0, // 无阴影
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  );

  final ButtonStyle _operatorButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.orange[300],
    foregroundColor: Colors.white,
    padding: const EdgeInsets.all(12),
    elevation: 0, // 无阴影
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  );

  final ButtonStyle _functionButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue[400],
    foregroundColor: Colors.white,
    padding: const EdgeInsets.all(12),
    elevation: 0, // 无阴影
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  );

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (_hasCalculated && !isOperator(buttonText) && !isFunction(buttonText)) {
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
        case '±':
          if (_input.isNotEmpty) {
            if (_input.startsWith('-')) {
              _input = _input.substring(1);
            } else {
              _input = '-$_input';
            }
          }
          break;
        case '=':
          if (_input.isNotEmpty) {
            _result = _calculatorService.calculate(_input);
            widget.onCalculation(_input, _result);
            _hasCalculated = true;
          }
          break;
        case 'sin':
        case 'cos':
        case 'tan':
        case 'log':
        case 'ln':
        case 'sqrt':
          if (_result.isNotEmpty && _result != '错误') {
            double value = double.parse(_result);
            _result = _calculatorService.scientificCalculate(_input, buttonText, value: value);
            _input = '$buttonText($_input)';
            widget.onCalculation(_input, _result);
            _hasCalculated = true;
          } else if (_input.isNotEmpty) {
            try {
              double value = double.parse(_input);
              _result = _calculatorService.scientificCalculate(_input, buttonText, value: value);
              _input = '$buttonText($_input)';
              widget.onCalculation(_input, _result);
              _hasCalculated = true;
            } catch (e) {
              _result = '错误';
            }
          }
          break;
        case 'x²':
          if (_result.isNotEmpty && _result != '错误') {
            double value = double.parse(_result);
            _result = _calculatorService.scientificCalculate(_input, 'square', value: value);
            _input = '($_input)²';
            widget.onCalculation(_input, _result);
            _hasCalculated = true;
          } else if (_input.isNotEmpty) {
            try {
              double value = double.parse(_input);
              _result = _calculatorService.scientificCalculate(_input, 'square', value: value);
              _input = '($_input)²';
              widget.onCalculation(_input, _result);
              _hasCalculated = true;
            } catch (e) {
              _result = '错误';
            }
          }
          break;
        case 'x!':
          if (_result.isNotEmpty && _result != '错误') {
            try {
              double value = double.parse(_result);
              _result = _calculatorService.scientificCalculate(_input, 'factorial', value: value);
              _input = '($_input)!';
              widget.onCalculation(_input, _result);
              _hasCalculated = true;
            } catch (e) {
              _result = '错误';
            }
          } else if (_input.isNotEmpty) {
            try {
              double value = double.parse(_input);
              _result = _calculatorService.scientificCalculate(_input, 'factorial', value: value);
              _input = '($_input)!';
              widget.onCalculation(_input, _result);
              _hasCalculated = true;
            } catch (e) {
              _result = '错误';
            }
          }
          break;
        case 'π':
          _input += '3.14159265359';
          break;
        case 'e':
          _input += '2.71828182846';
          break;
        case 'RAD/DEG':
          _isRadMode = !_isRadMode;
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
    return text == '+' || text == '-' || text == '×' || text == '÷' || text == '^';
  }

  bool isFunction(String text) {
    return text == 'sin' || text == 'cos' || text == 'tan' || text == 'log' || 
           text == 'ln' || text == 'sqrt' || text == 'x²' || text == 'x!' ||
           text == 'π' || text == 'e' || text == 'RAD/DEG' || text == '±';
  }

  @override
    Widget build(BuildContext context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          // 计算可用高度
          final availableHeight = constraints.maxHeight;
          // 显示区域和模式显示的固定高度
          final displayHeight = 110.0; // 减小显示区域高度
          final modeDisplayHeight = 25.0; // 减小模式显示高度
          // 计算按钮区域的可用高度
          final buttonsAreaHeight = availableHeight - displayHeight - modeDisplayHeight - 5; // 添加5像素的安全边距
          // 计算每个按钮行的高度（7行按钮）
          final buttonRowHeight = (buttonsAreaHeight / 7).floor().toDouble();
          
          return Column(
            children: [
              // 显示区域 - 极简扁平化设计
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.bottomRight,
                height: displayHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _input,
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _result,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black87),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              // 模式显示 - 极简扁平化设计
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                height: modeDisplayHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _isRadMode ? 'RAD' : 'DEG',
                  style: TextStyle(fontSize: 14, color: Colors.blue[400], fontWeight: FontWeight.w500),
                ),
              ),
              // 按钮区域 - 极简扁平化设计
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildButtonRow(['sin', 'cos', 'tan', 'C', '⌫'], buttonRowHeight),
                      buildButtonRow(['log', 'ln', 'sqrt', '(', ')'], buttonRowHeight),
                      buildButtonRow(['π', 'e', 'x²', 'x!', '^'], buttonRowHeight),
                      buildButtonRow(['7', '8', '9', '÷', 'RAD/DEG'], buttonRowHeight),
                      buildButtonRow(['4', '5', '6', '×', '%'], buttonRowHeight),
                      buildButtonRow(['1', '2', '3', '-', '±'], buttonRowHeight),
                      buildButtonRow(['0', '.', '00', '+', '='], buttonRowHeight),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

  Widget buildButtonRow(List<String> buttons, double height) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(bottom: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((buttonText) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.all(2),
              child: ElevatedButton(
                onPressed: () => _onButtonPressed(buttonText),
                style: isOperator(buttonText)
                    ? _operatorButtonStyle
                    : isFunction(buttonText)
                        ? _functionButtonStyle
                        : _numberButtonStyle,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}