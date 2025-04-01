import 'package:math_expressions/math_expressions.dart';

class CalculatorService {
  // 基础计算方法
  String calculate(String expression) {
    try {
      // 替换显示符号为计算符号
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      
      // 创建表达式解析器
      Parser p = Parser();
      Expression exp = p.parse(expression);
      
      // 创建上下文环境（用于变量赋值，这里不需要）
      ContextModel cm = ContextModel();
      
      // 计算结果
      double result = exp.evaluate(EvaluationType.REAL, cm);
      
      // 格式化结果（如果是整数则不显示小数点）
      if (result == result.toInt()) {
        return result.toInt().toString();
      } else {
        return result.toString();
      }
    } catch (e) {
      return '错误';
    }
  }
  
  // 科学计算方法
  String scientificCalculate(String expression, String function, {double? value}) {
    try {
      double result;
      
      // 根据不同的科学计算函数进行计算
      switch (function) {
        case 'sin':
          result = sin(value! * (3.14159265359 / 180)); // 转换为弧度
          break;
        case 'cos':
          result = cos(value! * (3.14159265359 / 180));
          break;
        case 'tan':
          result = tan(value! * (3.14159265359 / 180));
          break;
        case 'log':
          result = log(value!);
          break;
        case 'ln':
          result = ln(value!);
          break;
        case 'sqrt':
          result = sqrt(value!);
          break;
        case 'square':
          result = value! * value;
          break;
        case 'factorial':
          result = factorial(value!.toInt()).toDouble();
          break;
        default:
          return calculate(expression);
      }
      
      // 格式化结果
      if (result == result.toInt()) {
        return result.toInt().toString();
      } else {
        return result.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      return '错误';
    }
  }
  
  // 辅助方法：计算阶乘
  int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
  }
  
  // 辅助方法：计算正弦
  double sin(double radians) {
    return Parser().parse('sin($radians)').evaluate(EvaluationType.REAL, ContextModel());
  }
  
  // 辅助方法：计算余弦
  double cos(double radians) {
    return Parser().parse('cos($radians)').evaluate(EvaluationType.REAL, ContextModel());
  }
  
  // 辅助方法：计算正切
  double tan(double radians) {
    return Parser().parse('tan($radians)').evaluate(EvaluationType.REAL, ContextModel());
  }
  
  // 辅助方法：计算对数（以10为底）
  double log(double value) {
    return Parser().parse('log($value, 10)').evaluate(EvaluationType.REAL, ContextModel());
  }
  
  // 辅助方法：计算自然对数
  double ln(double value) {
    return Parser().parse('ln($value)').evaluate(EvaluationType.REAL, ContextModel());
  }
  
  // 辅助方法：计算平方根
  double sqrt(double value) {
    return Parser().parse('sqrt($value)').evaluate(EvaluationType.REAL, ContextModel());
  }
}