import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

bool evaluate(String inputdash, RxString output,
    Rx<TextEditingController> inputController) {
  Parser p = Parser();
  String input2 = inputdash;
  input2 += ")" *
      ("(".allMatches(inputdash).length - ")".allMatches(inputdash).length);
  Expression exp = p.parse(input2);
  ContextModel cm = ContextModel();
  String store = exp.evaluate(EvaluationType.REAL, cm).toString();
  double temp = double.parse(store);
  num mod = pow(10.0, 10);
  temp = ((temp * mod).round().toDouble() / mod);

  if (temp > 922337203) {
    output.value = "";
    Get.snackbar("Error", "Number too large",
        backgroundColor: const Color.fromARGB(255, 232, 101, 0),
        colorText: Colors.white,
        duration: const Duration(seconds: 1));
    return false;
  } else if (temp < -92337203) {
    output.value = "";
    Get.snackbar("Error", "Number too small",
        backgroundColor: const Color.fromARGB(255, 232, 101, 0),
        colorText: Colors.white,
        duration: const Duration(seconds: 1));
    return false;
  } else {
    output.value = temp.toString();
    inputController.value.text = inputdash;
    return true;
  }
}

List<String> operators = [
  "+",
  "-",
  "*",
  "/",
  "%",
];

bool validExp(String inputdash, RxString output) {
  if (inputdash.isEmpty) {
    return true;
  }
  for (int i = 0; i < inputdash.length - 1; i++) {
    if (operators.contains(inputdash[i]) &&
        operators.contains(inputdash[i + 1])) {
      String temp = inputdash[i] + inputdash[i + 1];
      if ((temp == "*+" ||
              temp == "*-" ||
              temp == "/+" ||
              temp == "/=" ||
              temp == "+-" ||
              temp == "-+") &&
          i + 2 < inputdash.length &&
          !operators.contains(inputdash[i + 2])) continue;
      output.value = "";
      Get.snackbar(
        "Error",
        "Invalid Expression",
        backgroundColor: const Color.fromARGB(255, 232, 101, 0),
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
      return false;
    }
  }
  if (operators.contains(inputdash[inputdash.length - 1])) {
    output.value = "";
    return false;
  }
  return true;
}

class CalculatorController extends GetxController {
  final inputController = TextEditingController().obs;
  final output = "".obs;

  void clear() {
    inputController.value.text = "";
    output.value = "";
    var cursorPos = inputController.value.selection;
    inputController.value.selection = cursorPos.copyWith(
      baseOffset: -1,
      extentOffset: -1,
    );
  }

  void delete() {
    if (inputController.value.text.isEmpty) {
      return;
    }
    var cursorPos = inputController.value.selection;
    if (cursorPos.baseOffset == -1) {
      String inputdash = inputController.value.text;
      inputdash = inputdash.substring(0, inputdash.length - 1);
      if (inputdash.isEmpty) {
        inputController.value.text = inputdash;
        output.value = "";
      } else {
        inputController.value.text = inputdash;
        output.value = "";
      }
    } else {
      if (cursorPos.baseOffset == cursorPos.extentOffset) {
        String righttext =
            cursorPos.extentOffset == inputController.value.text.length
                ? ""
                : inputController.value.text.substring(cursorPos.extentOffset);
        String lefttext = cursorPos.baseOffset == 0
            ? ""
            : inputController.value.text.substring(0, cursorPos.baseOffset - 1);
        String inputdash = lefttext + righttext;
        inputController.value.text = inputdash;
        output.value = "";
        inputController.value.selection = cursorPos.copyWith(
          baseOffset: cursorPos.baseOffset - 1,
          extentOffset: cursorPos.baseOffset - 1,
        );
      } else {
        String righttext =
            cursorPos.extentOffset == inputController.value.text.length
                ? ""
                : inputController.value.text.substring(cursorPos.extentOffset);
        String lefttext = cursorPos.baseOffset == 0
            ? ""
            : inputController.value.text.substring(0, cursorPos.baseOffset);
        String inputdash = lefttext + righttext;
        inputController.value.text = inputdash;
        output.value = "";
        inputController.value.selection = cursorPos.copyWith(
          baseOffset: cursorPos.baseOffset,
          extentOffset: cursorPos.baseOffset,
        );
      }
    }
  }

  void addInput(String s) {
    var cursorPos = inputController.value.selection;
    if (cursorPos.baseOffset == -1) {
      String inputdash = inputController.value.text;
      if (s == "±") {
        int i = inputdash.length;
        int j = i - 1;
        String check = "";
        for (; j >= 0; j--) {
          check = inputdash[j] + check;
          if (operators.contains(inputdash[j])) {
            break;
          }
        }
        if (j == -1) {
          inputdash = "-$inputdash";
          if (validExp(inputdash, output)) {
            evaluate(inputdash, output, inputController);
          }
        } else {
          if (check[0] == "*" || check[0] == "/" || check[0] == "%") {
            inputdash =
                "${inputdash.substring(0, j + 1)}(-${check.substring(1)}${inputdash.substring(i)}";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection =
                  const TextSelection.collapsed(offset: -1);
            }
          } else if (check[0] == "-") {
            inputdash =
                "${inputdash.substring(0, j)}+${check.substring(1)}${inputdash.substring(i)}";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection =
                  const TextSelection.collapsed(offset: -1);
            }
          } else if (check[0] == "+") {
            inputdash =
                "${inputdash.substring(0, j)}-${check.substring(1)}${inputdash.substring(i)}";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection =
                  const TextSelection.collapsed(offset: -1);
            }
          } else {
            inputdash =
                "${inputdash.substring(0, j)}-$check${inputdash.substring(i)}";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection = cursorPos.copyWith(
                baseOffset: cursorPos.baseOffset + 1,
                extentOffset: cursorPos.baseOffset + 1,
              );
            }
          }
        }
      } else if (s == "()") {
        if (inputController.value.text.isEmpty) {
          inputController.value.text = "(";
        } else if (inputController
                    .value.text[inputController.value.text.length - 1] ==
                "+" ||
            inputController.value.text[inputController.value.text.length - 1] ==
                "-" ||
            inputController.value.text[inputController.value.text.length - 1] ==
                "*" ||
            inputController.value.text[inputController.value.text.length - 1] ==
                "/") {
          inputController.value.text += "(";
        } else {
          inputController.value.text += ")";
        }
      } else {
        inputdash += s;
        if (validExp(inputdash, output)) {
          evaluate(inputdash, output, inputController);
        } else {
          inputController.value.text = inputdash;
        }
      }
    } else {
      String inputdash = inputController.value.text;
      if (s == "±") {
        int i = cursorPos.baseOffset;
        int j = i - 1;
        String check = "";
        for (; j >= 0; j--) {
          check = inputdash[j] + check;
          if (operators.contains(inputdash[j])) {
            break;
          }
        }
        if (j == -1) {
          inputdash = "-$inputdash";
          if (validExp(inputdash, output)) {
            evaluate(inputdash, output, inputController);
          }
        } else {
          if (check[0] == "*" || check[0] == "/" || check[0] == "%") {
            inputdash =
                "${inputdash.substring(0, j)}(-${check.substring(1)}${inputdash.substring(i)}";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection = cursorPos.copyWith(
                baseOffset: cursorPos.baseOffset + 2,
                extentOffset: cursorPos.baseOffset + 2,
              );
            }
          } else if (check[0] == "-") {
            inputdash =
                "${inputdash.substring(0, j)}+${check.substring(1)}${inputdash.substring(i)}";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection = cursorPos.copyWith(
                baseOffset: cursorPos.baseOffset + 1,
                extentOffset: cursorPos.baseOffset + 1,
              );
            }
          } else if (check[0] == "+") {
            inputdash =
                "${inputdash.substring(0, j)}-${check.substring(1)}${inputdash.substring(i)}";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection = cursorPos.copyWith(
                baseOffset: cursorPos.baseOffset + 1,
                extentOffset: cursorPos.baseOffset + 1,
              );
            }
          } else {
            inputdash =
                "${inputdash.substring(0, j)}-$check${inputdash.substring(i)}";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection = cursorPos.copyWith(
                baseOffset: cursorPos.baseOffset + 1,
                extentOffset: cursorPos.baseOffset + 1,
              );
            }
          }
        }
      } else if (s == "()") {
        int i = cursorPos.baseOffset;
        if (inputController.value.text.isEmpty) {
          inputController.value.text = "(";
        } else if (i == inputController.value.text.length) {
          if (operators.contains(inputController.value.text[i])) {
            inputController.value.text += "(";
          } else {
            inputController.value.text += ")";
          }
        } else {
          if (operators.contains(inputdash[i])) {
            String righttext = cursorPos.extentOffset == inputdash.length
                ? ""
                : inputdash.substring(cursorPos.extentOffset);
            String lefttext = i == 0 ? "" : inputdash.substring(0, i);
            inputdash = "$lefttext($righttext";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection = cursorPos.copyWith(
                baseOffset: cursorPos.baseOffset + 1,
                extentOffset: cursorPos.baseOffset + 1,
              );
            }
          } else {
            String righttext = cursorPos.extentOffset == inputdash.length
                ? ""
                : inputdash.substring(cursorPos.extentOffset);
            String lefttext = i == 0 ? "" : inputdash.substring(0, i);
            inputdash = "$lefttext)$righttext";
            if (validExp(inputdash, output) &&
                evaluate(inputdash, output, inputController)) {
              inputController.value.selection = cursorPos.copyWith(
                baseOffset: cursorPos.baseOffset + 1,
                extentOffset: cursorPos.baseOffset + 1,
              );
            }
          }
        }
      } else {
        String righttext = cursorPos.extentOffset == inputdash.length
            ? ""
            : inputdash.substring(cursorPos.extentOffset);
        String lefttext = cursorPos.baseOffset == 0
            ? ""
            : inputdash.substring(0, cursorPos.baseOffset);
        inputdash = lefttext + s + righttext;
        if (righttext == "") {
          inputController.value.text = inputdash;
          inputController.value.selection = cursorPos.copyWith(
            baseOffset: cursorPos.baseOffset + 1,
            extentOffset: cursorPos.extentOffset + 1,
          );
        } else if (validExp(inputdash, output) &&
            evaluate(inputdash, output, inputController)) {
          inputController.value.selection = cursorPos.copyWith(
            baseOffset: cursorPos.baseOffset + 1,
            extentOffset: cursorPos.extentOffset + 1,
          );
        }
      }
    }
  }

  void result() {
    if (validExp(inputController.value.text, output)) {
      Parser p = Parser();
      String input2 = inputController.value.text;
      input2 +=
          ")" * ("(".allMatches(input2).length - ")".allMatches(input2).length);
      Expression exp = p.parse(input2);
      ContextModel cm = ContextModel();
      String store = exp.evaluate(EvaluationType.REAL, cm).toString();
      double temp = double.parse(store);
      num mod = pow(10.0, 10);
      temp = ((temp * mod).round().toDouble() / mod);
      if (temp > 922337203) {
        Get.snackbar("Error", "Number too large",
            backgroundColor: const Color.fromARGB(255, 232, 101, 0),
            colorText: Colors.white,
            duration: const Duration(seconds: 1));
        return;
      } else if (temp < -92337203) {
        Get.snackbar("Error", "Number too small",
            backgroundColor: const Color.fromARGB(255, 232, 101, 0),
            colorText: Colors.white,
            duration: const Duration(seconds: 1));
        return;
      } else {
        output.value = temp.toString();
        inputController.value.text = output.value;
        output.value = "";
      }
    }
  }
}
