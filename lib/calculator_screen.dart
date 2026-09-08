import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  double? firstNumber;
  String? operator;
  bool shouldResetDisplay = false;

  void numberPressed(String number) {
    setState(() {
      if (display == '0' || shouldResetDisplay) {
        display = number;
        shouldResetDisplay = false;
      } else {
        display += number;
      }
    });
  }

  void decimalPressed() {
    setState(() {
      if (shouldResetDisplay) {
        display = '0.';
        shouldResetDisplay = false;
      } else if (!display.contains('.')) {
        display += '.';
      }
    });
  }

  void operatorPressed(String op) {
    final currentNumber = double.tryParse(display);

    if (currentNumber == null) return;

    if (firstNumber != null && operator != null) {
      calculateResult();
    } else {
      firstNumber = currentNumber;
    }

    setState(() {
      operator = op;
      shouldResetDisplay = true;
    });
  }

  void calculateResult() {
    final secondNumber = double.tryParse(display);

    if (firstNumber == null ||
        operator == null ||
        secondNumber == null) {
      return;
    }

    double result = 0;

    switch (operator) {
      case '+':
        result = firstNumber! + secondNumber;
        break;

      case '-':
        result = firstNumber! - secondNumber;
        break;

      case '×':
        result = firstNumber! * secondNumber;
        break;

      case '÷':
        if (secondNumber == 0) {
          display = 'Error';
          firstNumber = null;
          operator = null;
          shouldResetDisplay = true;
          return;
        }
        result = firstNumber! / secondNumber;
        break;
    }

    setState(() {
      display = formatNumber(result);
      firstNumber = null;
      operator = null;
      shouldResetDisplay = true;
    });
  }

  String formatNumber(double number) {
    if (number == number.roundToDouble()) {
      return number.toInt().toString();
    }

    return number.toStringAsFixed(8).replaceFirst(
          RegExp(r'0+$'),
          '',
        );
  }

  void clearCalculator() {
    setState(() {
      display = '0';
      firstNumber = null;
      operator = null;
      shouldResetDisplay = false;
    });
  }

  void deleteLast() {
    setState(() {
      if (display.length <= 1 || display == 'Error') {
        display = '0';
      } else {
        display = display.substring(0, display.length - 1);
      }
    });
  }

  Widget calculatorButton(
    String text, {
    VoidCallback? onTap,
    bool operatorButton = false,
    bool equalButton = false,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Material(
          color: operatorButton
              ? const Color(0xFF246B4A)
              : equalButton
                  ? const Color(0xFFC9A45C)
                  : Colors.white,
          borderRadius: BorderRadius.circular(18),
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: operatorButton || equalButton
                      ? Colors.white
                      : const Color(0xFF183329),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EA),
      appBar: AppBar(
        title: const Text(
          'ক্যালকুলেটর',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF164A35),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Display
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF164A35),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF164A35).withOpacity(0.18),
                    blurRadius: 15,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (firstNumber != null && operator != null)
                    Text(
                      '${formatNumber(firstNumber!)} $operator',
                      style: const TextStyle(
                        color: Color(0xFFC9A45C),
                        fontSize: 16,
                      ),
                    ),

                  const SizedBox(height: 5),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      display,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Buttons
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        calculatorButton(
                          'AC',
                          onTap: clearCalculator,
                        ),
                        calculatorButton(
                          '⌫',
                          onTap: deleteLast,
                        ),
                        calculatorButton(
                          '÷',
                          operatorButton: true,
                          onTap: () => operatorPressed('÷'),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        calculatorButton(
                          '7',
                          onTap: () => numberPressed('7'),
                        ),
                        calculatorButton(
                          '8',
                          onTap: () => numberPressed('8'),
                        ),
                        calculatorButton(
                          '9',
                          onTap: () => numberPressed('9'),
                        ),
                        calculatorButton(
                          '×',
                          operatorButton: true,
                          onTap: () => operatorPressed('×'),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        calculatorButton(
                          '4',
                          onTap: () => numberPressed('4'),
                        ),
                        calculatorButton(
                          '5',
                          onTap: () => numberPressed('5'),
                        ),
                        calculatorButton(
                          '6',
                          onTap: () => numberPressed('6'),
                        ),
                        calculatorButton(
                          '-',
                          operatorButton: true,
                          onTap: () => operatorPressed('-'),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        calculatorButton(
                          '1',
                          onTap: () => numberPressed('1'),
                        ),
                        calculatorButton(
                          '2',
                          onTap: () => numberPressed('2'),
                        ),
                        calculatorButton(
                          '3',
                          onTap: () => numberPressed('3'),
                        ),
                        calculatorButton(
                          '+',
                          operatorButton: true,
                          onTap: () => operatorPressed('+'),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        calculatorButton(
                          '0',
                          onTap: () => numberPressed('0'),
                        ),
                        calculatorButton(
                          '.',
                          onTap: decimalPressed,
                        ),
                        calculatorButton(
                          '=',
                          equalButton: true,
                          onTap: calculateResult,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
