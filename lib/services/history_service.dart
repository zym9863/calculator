import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';

class HistoryService {
  static const String _historyKey = 'calculation_history';

  // 保存历史记录
  Future<void> saveHistory(List<CalculationHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = history.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_historyKey, historyJson);
  }

  // 获取历史记录
  Future<List<CalculationHistory>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey) ?? [];
    return historyJson
        .map((item) => CalculationHistory.fromJson(jsonDecode(item)))
        .toList();
  }

  // 添加新的计算记录
  Future<List<CalculationHistory>> addCalculation(
      String expression, String result) async {
    final history = await getHistory();
    final newCalculation = CalculationHistory(
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
    );
    history.insert(0, newCalculation); // 添加到列表开头
    await saveHistory(history);
    return history;
  }

  // 清除历史记录
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  // 删除单条历史记录
  Future<void> deleteCalculation(DateTime timestamp) async {
    final history = await getHistory();
    history.removeWhere((item) => item.timestamp.isAtSameMomentAs(timestamp));
    await saveHistory(history);
  }
}