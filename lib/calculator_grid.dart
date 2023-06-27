import 'package:calculator/widgets/icons.dart';
import 'package:get/get.dart';
import 'controllers/CalculatorController.dart';

final CalculatorController calculatorController =
    Get.put(CalculatorController());
var calculatorGrid = [
  CalculatorIcon.red(
    text: "C",
    callback: calculatorController.clear,
  ),
  CalculatorIcon.red(
    text: "()",
    callback: () => calculatorController.addInput("()"),
  ),
  CalculatorIcon.black(
    text: "%",
    callback: () => calculatorController.addInput("%"),
  ),
  CalculatorIcon.black(
    text: "÷",
    callback: () => calculatorController.addInput("/"),
  ),
  CalculatorIcon.white(
    text: "7",
    callback: () => calculatorController.addInput("7"),
  ),
  CalculatorIcon.white(
    text: "8",
    callback: () => calculatorController.addInput("8"),
  ),
  CalculatorIcon.white(
    text: "9",
    callback: () => calculatorController.addInput("9"),
  ),
  CalculatorIcon.black(
    text: "×",
    callback: () => calculatorController.addInput("*"),
  ),
  CalculatorIcon.white(
    text: "4",
    callback: () => calculatorController.addInput("4"),
  ),
  CalculatorIcon.white(
    text: "5",
    callback: () => calculatorController.addInput("5"),
  ),
  CalculatorIcon.white(
    text: "6",
    callback: () => calculatorController.addInput("6"),
  ),
  CalculatorIcon.black(
    text: "-",
    callback: () => calculatorController.addInput("-"),
  ),
  CalculatorIcon.white(
    text: "1",
    callback: () => calculatorController.addInput("1"),
  ),
  CalculatorIcon.white(
    text: "2",
    callback: () => calculatorController.addInput("2"),
  ),
  CalculatorIcon.white(
    text: "3",
    callback: () => calculatorController.addInput("3"),
  ),
  CalculatorIcon.black(
    text: "+",
    callback: () => calculatorController.addInput("+"),
  ),
  CalculatorIcon.white(
    text: "±",
    callback: () => calculatorController.addInput("±"),
  ),
  CalculatorIcon.white(
    text: "0",
    callback: () => calculatorController.addInput("0"),
  ),
  CalculatorIcon.white(
    text: ".",
    callback: () => calculatorController.addInput("."),
  ),
  CalculatorIcon.equals(
    text: "=",
    callback: () => calculatorController.result(),
  ),
];
