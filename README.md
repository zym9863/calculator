# Flutter 计算器应用

中文 | [English](README_EN.md)

一个功能完善的Flutter计算器应用，提供基础计算和科学计算功能，并支持计算历史记录。

## 功能特点

### 基础计算器
- 支持加减乘除等基本运算
- 清晰的显示界面，包括输入表达式和计算结果
- 支持连续计算和结果复用

### 科学计算器
- 支持三角函数计算（sin、cos、tan）
- 支持对数计算（log、ln）
- 支持平方、开方、阶乘等高级运算
- 角度/弧度模式切换

### 历史记录
- 自动保存计算历史
- 查看、删除单条历史记录
- 一键清空所有历史记录

## 项目结构

```
lib/
├── main.dart              # 应用入口文件
├── models/
│   └── calculation_history.dart  # 计算历史数据模型
├── screens/
│   ├── basic_calculator.dart     # 基础计算器界面
│   ├── scientific_calculator.dart # 科学计算器界面
│   └── history_screen.dart       # 历史记录界面
└── services/
    ├── calculator_service.dart   # 计算逻辑服务
    └── history_service.dart      # 历史记录管理服务
```

## 技术实现

- 使用Flutter框架开发，支持跨平台部署
- 采用Material Design设计风格
- 使用math_expressions库进行数学表达式解析和计算
- 使用shared_preferences进行本地数据存储
- 采用Tab布局实现基础/科学计算器的切换

## 开始使用

### 前提条件

- 安装Flutter SDK
- 配置好开发环境

### 安装步骤

1. 克隆项目到本地
   ```
   git clone https://github.com/zym9863/calculator.git
   ```

2. 安装依赖
   ```
   flutter pub get
   ```

3. 运行应用
   ```
   flutter run
   ```

## 学习资源

如果你是Flutter新手，以下资源可能对你有帮助：

- [Flutter官方文档](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter入门教程](https://docs.flutter.dev/get-started/codelab)
