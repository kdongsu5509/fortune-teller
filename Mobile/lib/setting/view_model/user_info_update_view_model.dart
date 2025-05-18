import 'package:ai_fortune_teller_app/setting/repository/model/birth_time.dart';
import 'package:ai_fortune_teller_app/setting/repository/model/user_info_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/user_info_provider.dart';

class UserInfoUpdateViewModel extends ChangeNotifier {
  final Ref ref;
  UserInfoDTO? userInfo;

  UserInfoUpdateViewModel(this.ref) {
    userInfo = ref.read(userInfoProvider);
  }

  final TextEditingController nameController = TextEditingController();
  int? selectedYear;
  int? selectedMonth;
  int? selectedDay;
  int? selectedGender = 1;
  BirthTime selectedTime = BirthTime.Missing;

  final List<int> years = List.generate(60, (i) => DateTime.now().year - i);
  final List<int> months = List.generate(12, (i) => i + 1);
  List<int> days = [];
  final List<int> sex = [1, 2];

  Future<void> init() async {
    if (userInfo != null) {
      nameController.text = userInfo!.name;
      selectedYear = userInfo!.birthDate.year;
      selectedMonth = userInfo!.birthDate.month;
      selectedDay = userInfo!.birthDate.day;
      selectedTime = userInfo!.birthTime;
    } else {
      nameController.text = "";
      selectedYear = null;
      selectedMonth = null;
      selectedDay = null;
      selectedTime = BirthTime.Missing;
    }
    generateDayList();
  }

  void generateDayList() {
    int maxDay = 31;
    if (selectedMonth != null) {
      switch (selectedMonth) {
        case 2:
          if (selectedYear != null &&
              ((selectedYear! % 4 == 0 && selectedYear! % 100 != 0) ||
                  selectedYear! % 400 == 0)) {
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

  Future<void> updateUserInfo() async {
    userInfo = UserInfoDTO(
      name: nameController.text,
      birthDate: DateTime(selectedYear!, selectedMonth!, selectedDay!),
      birthTime: selectedTime,
      gender: selectedGender == 1 ? "남자" : "여자",
    );
    await ref.read(userInfoProvider.notifier).updateUserInfo(userInfo!);
  }
}
