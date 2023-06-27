import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../calculator_grid.dart';
import '../controllers/CalculatorController.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final CalculatorController calculatorController =
      Get.put(CalculatorController());
  var calcgrid = [];

// double num1 = 0;
  // double num2 = 0;
  // String operand = "";
  // String result = "";
  // String _output = "";
  // String input = "0";

  // void calcFunction(String inputVal) {
  //   if (inputVal == "C") {
  //     _output = "";
  //     num1 = 0;
  //     num2 = 0;
  //     operand = "";
  //     result = "";
  //     input = "";
  //   } else {
  //     // if (input.isEmpty && _output.isNotEmpty) {
  //     //   input = _output;
  //     // }
  //     if (inputVal == "+" ||
  //         inputVal == "-" ||
  //         inputVal == "X" ||
  //         inputVal == "/") {
  //       num1 = double.parse(input);
  //       operand = inputVal;
  //       _output += inputVal;
  //       input = "";
  //     } else if (inputVal == "+/-") {
  //       if (input[0] == "-") {
  //         input = input.substring(1);
  //       } else {
  //         input = "-$input";
  //       }
  //     } else if (inputVal == ".") {
  //       if (input.contains(".")) {
  //         print("Already contains a decimal");
  //         return;
  //       } else {
  //         _output += inputVal;
  //         input += inputVal;
  //       }
  //     } else if (inputVal == "=") {
  //       num2 = double.parse(input);
  //       if (operand == "+") {
  //         result = (num1 + num2).toString();
  //       }
  //       if (operand == "-") {
  //         result = (num1 - num2).toString();
  //       }
  //       if (operand == "X") {
  //         result = (num1 * num2).toString();
  //       }
  //       if (operand == "/") {
  //         result = (num1 / num2).toString();
  //       }
  //       num1 = 0;
  //       num2 = 0;
  //       operand = "";
  //       input = result;
  //       _output = result;
  //     } else {
  //       input += inputVal;
  //       _output += inputVal;
  //     }
  //   }
  //   print(input);
  //   setState(() {
  //     if (_output.length > 10) {
  //       _output = _output.substring(0, 10);
  //     } else {
  //       _output = _output;
  //     }
  //     // _output = _output.length()>10?_output.substring(0,10):_output;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          var screenheight = constraints.maxHeight;
          return Column(
            children: [
              Container(
                height: screenheight * 0.15,
                margin: EdgeInsets.fromLTRB(0, screenheight * 0.05, 8, 0),
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: screenheight * 0.11),
                    child: SingleChildScrollView(
                      child: GetX<CalculatorController>(builder: (_) {
                        return TextFormField(
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          maxLines: null,
                          textAlign: TextAlign.right,
                          controller:
                              calculatorController.inputController.value,
                          style: TextStyle(
                              fontSize: screenheight * 0.04,
                              color: Colors.white),
                          keyboardType: TextInputType.none,
                        );
                      }),
                    ),
                  ),
                ),
              ),
              Container(
                height: screenheight * 0.07,
                margin: EdgeInsets.fromLTRB(0, 0, 8, screenheight * 0.01),
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GetX<CalculatorController>(
                    builder: (_) {
                      return Text(
                        "${calculatorController.output}",
                        style: TextStyle(
                            fontSize: screenheight * 0.04,
                            color: Colors.white54),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, screenheight * 0.015, 0, 0),
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF00E676),
                  ),
                  onPressed: () => calculatorController.delete(),
                  icon: const Icon(Icons.backspace_outlined),
                  label: const Text(""),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: calculatorGrid.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return calculatorGrid[index];
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
