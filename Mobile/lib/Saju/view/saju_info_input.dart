import 'package:flutter/material.dart';
import '../../DataLayer/Dto/user_info_dto.dart';
import '../../View/result_view.dart';
import '../../ViewModel/info_input_view_model.dart';

class InfoInputView extends StatefulWidget {
  const InfoInputView({super.key});

  @override
  State<InfoInputView> createState() => _InfoInputViewState();
}

class _InfoInputViewState extends State<InfoInputView> {
  final TextEditingController _controller = TextEditingController();

  int? selectedYear;
  int? selectedMonth;
  int? selectedDay;
  int? selectedGender = 1;

  final List<int> years = List.generate(60, (i) => DateTime.now().year - i);
  final List<int> months = List.generate(12, (i) => i + 1);
  List<int> days = [];
  final List<int> sex = [1, 2];

  bool _isLoading = false;

  void toggleLoading() => setState(() => _isLoading = !_isLoading);

  @override
  void initState() {
    super.initState();
    selectedYear = years.contains(DateTime.now().year) ? DateTime.now().year : null;
    selectedMonth = DateTime.now().month;
    selectedDay = DateTime.now().day;
    _updateDays();
  }

  void _updateDays() {
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

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("정보 입력"),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.08),
        child: ListView(
          children: [
            SizedBox(height: sh * 0.05),
            const Text(
              "아래 입력한 정보는 분석에만 사용됩니다.\n서버 및 해당 기기에 저장되지 않습니다.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: sh * 0.05),
            TextField(
              controller: _controller,
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
                _dropdownButton(years, "생년"),
                _dropdownButton(months, "생월"),
                _dropdownButton(days, "생일"),
                _dropdownButton(sex, "성별"),
              ],
            ),
            SizedBox(height: sh * 0.06),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: () async {
                if (_controller.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("이름을 입력하세요.")),
                  );
                  return;
                }

                final name = _controller.text.trim();
                final genderStr = selectedGender == 1 ? "남자" : "여자";
                final dto = UserInfoDTO(
                  name: name,
                  year: selectedYear!,
                  month: selectedMonth!,
                  day: selectedDay!,
                  gender: genderStr,
                );

                toggleLoading();
                await InfoInputViewModel().analyzeReqToRepo(dto);
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
        selected = selectedYear;
        break;
      case "생월":
        selected = selectedMonth;
        break;
      case "생일":
        selected = selectedDay;
        break;
      case "성별":
        selected = selectedGender;
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
            child: Text(isSex ? (value == 1 ? "남자" : "여자") : "$value"),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            switch (label) {
              case "생년":
                selectedYear = value;
                _updateDays();
                break;
              case "생월":
                selectedMonth = value;
                _updateDays();
                break;
              case "생일":
                selectedDay = value;
                break;
              case "성별":
                selectedGender = value;
                break;
            }
          });
        },
      ),
    );
  }
}