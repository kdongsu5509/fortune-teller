import 'package:ai_fortune_teller_app/Saju/view_model/saju_info_input_view_model.dart';
import 'package:flutter/material.dart';
import '../../setting/repository/model/user_info_dto.dart';
import '../../View/result_view.dart';
import '../../ViewModel/info_input_view_model.dart';

class InfoInputView extends StatefulWidget {
  const InfoInputView({super.key});

  @override
  State<InfoInputView> createState() => _InfoInputViewState();
}

class _InfoInputViewState extends State<InfoInputView> {
  SajuInfoInputViewModel viewModel = SajuInfoInputViewModel();
  bool _isLoading = false;

  void toggleLoading() => setState(() => _isLoading = !_isLoading);

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.08),
        child: ListView(
          children: [
            SizedBox(height: sh * 0.2),
            Text(
              "사용자 정보 입력",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: sh * 0.03),
            TextField(
              controller: viewModel.controller,
              decoration: InputDecoration(
                labelText: "이름을 입력하세요",
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: sh * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dropdownButton(viewModel.years, "생년"),
                _dropdownButton(viewModel.months, "생월"),
                _dropdownButton(viewModel.days, "생일"),
                _dropdownButton(viewModel.sex, "성별"),
              ],
            ),
            SizedBox(height: sh * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dropdownButton(List.generate(24, (i) => i), "생시"),
                _dropdownButton(List.generate(60, (i) => i), "생분"),
              ],
            ),
            SizedBox(height: sh * 0.06),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: () async {
                if (viewModel.controller.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("이름을 입력하세요.")),
                  );
                  return;
                }

                final name = viewModel.controller.text.trim();
                final genderStr = viewModel.selectedGender == 1 ? "남자" : "여자";
                // final dto = UserInfoDTO(
                //   name: name,
                //   year: viewModel.selectedYear!,
                //   month: viewModel.selectedMonth!,
                //   day: viewModel.selectedDay!,
                //   gender: genderStr,
                //   hour: viewModel.selectedHour!,
                //   minute: viewModel.selectedMinute!,
                // );

                toggleLoading();
                // await InfoInputViewModel().analyzeReqToRepo(dto);
                toggleLoading();

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ResultView()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text("분석 요청", style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: sh * 0.05),
          ],
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
      width: MediaQuery.of(context).size.width * 0.18,
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