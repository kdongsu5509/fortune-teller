import 'package:ai_fortune_teller_app/setting/repository/model/birth_time.dart';
import 'package:ai_fortune_teller_app/setting/view_model/user_info_update_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/model/user_info_dto.dart';
import '../util/user_info_provider.dart';

class UserInfoUpdateView extends ConsumerStatefulWidget {
  const UserInfoUpdateView({super.key});

  @override
  ConsumerState<UserInfoUpdateView> createState() => _UserInfoUpdateViewState();
}

class _UserInfoUpdateViewState extends ConsumerState<UserInfoUpdateView> {
  final UserInfoUpdateViewModel viewModel = UserInfoUpdateViewModel();
  final TextEditingController _nameController = TextEditingController();
  UserInfoDTO? userInfo;
  late DateTime selectedDate;
  late BirthTime selectedTime;

  @override
  void initState() {
    super.initState();
    userInfo = ref.read(userInfoProvider);
    if (userInfo != null) {
      _nameController.text = userInfo!.name;
      selectedDate = userInfo!.birthDate;
      selectedTime = userInfo!.birthTime;
    } else {
      selectedDate = DateTime.now();
      selectedTime = BirthTime.Missing;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final isSmall = sw < 400;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.06, vertical: sh * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pageTitle(),
            SizedBox(height: sh * 0.03),
            _name(sw, sh, isSmall),
            SizedBox(height: sh * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dropdownButton(viewModel.years, "생년"),
                _dropdownButton(viewModel.months, "생월"),
                _dropdownButton(viewModel.days, "생일"),
              ],
            ),
            SizedBox(height: sh * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dropdownButton(viewModel.sex, "성별"),
              ],
            ),
            SizedBox(height: sh * 0.03),
            InkWell(
              onTap: () async {
                final picked = await showModalBottomSheet<String>(
                  context: context,
                  builder: (context) => ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: 13,
                    itemBuilder: (context, index) {
                      final time = BirthTime.values[index].name;
                      return ListTile(
                        title: Text(BirthTime.values[index].label),
                        onTap: () => Navigator.pop(context, time),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(height: 1),
                  ),
                );
                if (picked != null) {
                  setState(() => selectedTime = BirthTime.values.firstWhere((e) => e.name == picked));
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTime.label,
                      style: TextStyle(fontSize: isSmall ? 14 : 16),
                    ),
                    const Icon(Icons.expand_more, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("이름을 입력해주세요")),
                    );
                    return;
                  }
                  if (selectedDate.isAfter(DateTime.now())) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("생년월일이 잘못되었습니다")),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("저장 완료")),
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  "저장",
                  style: TextStyle(
                    fontSize: isSmall ? 14 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: sh * 0.02),
          ],
        ),
      ),
    );
  }
  Widget _pageTitle() {
    return Text(
      "사용자 정보 수정",
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontFamily: "ChosunCentennial",
      ),
    );
  }

  Widget _name(double sw, double sh, bool isSmall) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.018),
      child: TextField(
        controller: _nameController,
        style: TextStyle(fontSize: isSmall ? 14 : 16),
        decoration: const InputDecoration(
          labelText: "이름",
          border: InputBorder.none,
        ),
      ),
    );
  }


  Widget _dropdownButton(List<int> items, String label) {
    final isSex = label == "성별";

    int? selected;
    switch (label) {
      case "생년":
        selected = viewModel.selectedYear;
        break;
      case "생월":
        selected = viewModel.selectedMonth;
        break;
      case "생일":
        selected = viewModel.selectedDay;
        break;
      case "성별":
        selected = viewModel.selectedGender;
        break;
      case "생시":
        selected = viewModel.selectedHour;
        break;
      case "생분":
        selected = viewModel.selectedMinute;
        break;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.width * 0.1,
      child: DropdownButtonFormField<int>(
        value: selected,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(label == "생시"
                ? "$value시"
                : label == "생분"
                ? "$value분"
                : isSex
                ? (value == 1 ? "남자" : "여자")
                : "$value"),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            switch (label) {
              case "생년":
                viewModel.selectedYear = value;
                viewModel.updateDays();
                break;
              case "생월":
                viewModel.selectedMonth = value;
                viewModel.updateDays();
                break;
              case "생일":
                viewModel.selectedDay = value;
                break;
              case "성별":
                viewModel.selectedGender = value;
                break;
              case "생시":
                viewModel.selectedHour = value;
                break;
              case "생분":
                viewModel.selectedMinute = value;
                break;
            }
          });
        },
      ),
    );
  }
}

