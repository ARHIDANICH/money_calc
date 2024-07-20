import 'dart:ffi';
import 'dart:math';

import 'package:scoped_model/scoped_model.dart';

class CalcModel extends Model {
  double startingSum = 0;
  int percentage = 10;
  int monthCount = 1;

  double totalSumBy(int _monthCount) =>
      startingSum * pow((1 + percentage / 1200), _monthCount);
  double incomeBySpecificMonth(int monthNumber) => totalSumBy(monthNumber) - totalSumBy(monthNumber - 1);
  double totalIncome(int _monthCount) => totalSumBy(_monthCount) - startingSum;
}
