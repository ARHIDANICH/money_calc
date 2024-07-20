import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_calc/source/logic.dart';
import 'package:scoped_model/scoped_model.dart';

enum percentages { fourth, ten, eleven, custom }

class MainWidget extends StatelessWidget {
  MainWidget({super.key});
  percentages sliderValue = percentages.ten;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CalcModel>(
      builder: (context, child, model) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text(
              'МИНИМАЛЬНЫЙ ОСТАТОК',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            IntrinsicWidth(
              child: TextField(
                decoration: const InputDecoration(
                  suffix: Text(
                    "₽",
                    textAlign: TextAlign.left,
                  ),
                ),
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  RegExp check = RegExp("\\d");
                  if (check.hasMatch(value)) {
                    model.startingSum = double.parse(value);
                    model.notifyListeners();
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            const Text(
              'ПРОЦЕНТНАЯ СТАВКА',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Radio(
                        value: percentages.fourth,
                        groupValue: sliderValue,
                        onChanged: (val) {
                          sliderValue = percentages.fourth;
                          model.percentage = 4;
                          model.notifyListeners();
                        }),
                    const Text("4%"),
                  ],
                ),
                Column(
                  children: [
                    Radio(
                        value: percentages.ten,
                        groupValue: sliderValue,
                        onChanged: (val) {
                          sliderValue = percentages.ten;
                          model.percentage = 10;
                          model.notifyListeners();
                        }),
                    const Text("10%"),
                  ],
                ),
                Column(
                  children: [
                    Radio(
                        value: percentages.eleven,
                        groupValue: sliderValue,
                        onChanged: (val) {
                          sliderValue = percentages.eleven;
                          model.percentage = 11;
                          model.notifyListeners();
                        }),
                    const Text("11%"),
                  ],
                ),
                Column(
                  children: [
                    Radio(
                        value: percentages.custom,
                        groupValue: sliderValue,
                        onChanged: (val) {
                          sliderValue = percentages.custom;
                          model.notifyListeners();
                        }),
                    Container(
                      width: 40,
                      height: 20,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          RegExp check = RegExp("\\d");
                          if (check.hasMatch(value) && int.parse(value) > 0) {
                            sliderValue = percentages.custom;
                            model.percentage = int.parse(value);
                            model.notifyListeners();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            const Text(
              'ПРОДОЛЖИТЕЛЬНОСТЬ',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Slider(
              label: "${model.monthCount}",
              value: model.monthCount.toDouble(),
              onChanged: (val) {
                model.monthCount = val.toInt();
                model.notifyListeners();
              },
              min: 1,
              max: 12,
            ),
            SizedBox(height: 20),
            Text(
              'СУММА НА ${model.monthCount} МЕСЯЦ',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Text(
              "${model.totalSumBy(model.monthCount).toStringAsFixed(2)} ₽",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "ОБЩИЙ ДОХОД",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Text(
              "${model.totalIncome(model.monthCount).toStringAsFixed(2)} ₽",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "ДОХОД ПО МЕСЯЦАМ:",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Column(
              children: _buildIncomeList(model),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildIncomeList(CalcModel model) {
  List<Widget> result = [];

  for (int i = 0; i < model.monthCount; i++) {
    result.add(
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: Text(
            "${i + 1} месяц: ${model.incomeBySpecificMonth(i+1).toStringAsFixed(2)} ₽"),
      ),
    );
  }

  return result;
}
