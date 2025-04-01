# Flutter Calculator App

[中文](README.md) | English

A fully-featured Flutter calculator app that provides basic calculation and scientific calculation functions, with support for calculation history.

## Features

### Basic Calculator
- Supports basic operations such as addition, subtraction, multiplication, and division
- Clear display interface, including input expressions and calculation results
- Supports continuous calculation and result reuse

### Scientific Calculator
- Supports trigonometric function calculations (sin, cos, tan)
- Supports logarithmic calculations (log, ln)
- Supports advanced operations such as square, square root, factorial, etc.
- Angle/radian mode switching

### History Record
- Automatically saves calculation history
- View and delete individual history records
- One-click to clear all history records

## Project Structure

```
lib/
├── main.dart              # Application entry file
├── models/
│   └── calculation_history.dart  # Calculation history data model
├── screens/
│   ├── basic_calculator.dart     # Basic calculator interface
│   ├── scientific_calculator.dart # Scientific calculator interface
│   └── history_screen.dart       # History record interface
└── services/
    ├── calculator_service.dart   # Calculation logic service
    └── history_service.dart      # History record management service
```

## Technical Implementation

- Developed using Flutter framework, supporting cross-platform deployment
- Adopts Material Design style
- Uses math_expressions library for mathematical expression parsing and calculation
- Uses shared_preferences for local data storage
- Uses Tab layout to implement switching between basic/scientific calculators

## Getting Started

### Prerequisites

- Install Flutter SDK
- Configure the development environment

### Installation Steps

1. Clone the project locally
   ```
   git clone https://github.com/zym9863/calculator.git
   ```

2. Install dependencies
   ```
   flutter pub get
   ```

3. Run the application
   ```
   flutter run
   ```

## Learning Resources

If you are new to Flutter, the following resources may be helpful to you:

- [Flutter Official Documentation](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter Getting Started Tutorial](https://docs.flutter.dev/get-started/codelab)