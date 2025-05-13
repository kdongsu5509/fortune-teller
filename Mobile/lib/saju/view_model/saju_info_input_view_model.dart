import 'package:flutter/material.dart';

class SajuInfoInputViewModel {
  final TextEditingController controller = TextEditingController();

  int? selectedYear;
  int? selectedMonth;
  int? selectedDay;
  int? selectedGender = 1;
  int? selectedHour = 0;
  int? selectedMinute = 0;

  final List<int> years = List.generate(60, (i) => DateTime.now().year - i);
  final List<int> months = List.generate(12, (i) => i + 1);
  List<int> days = [];
  final List<int> sex = [1, 2];

  Future<void> init() async {
    selectedYear = years.contains(DateTime.now().year) ? DateTime.now().year : null;
    selectedMonth = DateTime.now().month;
    selectedDay = DateTime.now().day;
    updateDays();
  }

  void updateDays() {
    int maxDay = 31;
    if (selectedMonth != null) {
      switch (selectedMonth) {
        case 2:
          if (selectedYear != null &&
              ((selectedYear! % 4 == 0 && selectedYear! % 100 != 0) || selectedYear! % 400 == 0)) {
            maxDay = 29;
          } else {
            maxDay = 28;
          }
          break;
        case 4:
        case 6:
        case 9:
        case 11:
          maxDay = 30;
          break;
      }
    }
    days = List.generate(maxDay, (i) => i + 1);
    if (selectedDay != null && selectedDay! > maxDay) {
      selectedDay = maxDay;
    }
  }
}