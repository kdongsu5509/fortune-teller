import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:knucl_face_analyzer_2025/View/result_view.dart';

import '../DataLayer/Dto/user_info_dto.dart';
import '../ViewModel/info_input_view_model.dart';
import '../common/device_info.dart';

class InfoInputView extends StatefulWidget {
    const InfoInputView({super.key});

    @override
    State<InfoInputView> createState() => _ImageUploadViewState();
}

class _ImageUploadViewState extends State<InfoInputView> {
    TextEditingController _controller = TextEditingController();
    int? selectedYear = DateTime.now().year;
    int? selectedMonth = DateTime.now().month;
    int? selectedDay = DateTime.now().day;
    int? selectedGender = 1;

    List<int> years = List.of({2008,2007,2006,2005,2004,2003,2002,2001,2000,1999,1998,1997,1996,1995});
    List<int> months = List.of({1,2,3,4,5,6,7,8,9,10,11,12});
    List<int> days = List.of({1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31});
    List<int> sex = List.of({1,2});
    bool _isLoading = false;

    void whenLoading() {
        setState(() {
            _isLoading = !_isLoading;
        });
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("정보 입력"),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0
            ),
            body: Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        _infoText(context),
                        Text("현재 입력된 정보 : ${selectedYear}년 ${selectedMonth}월 ${selectedDay}일 ${selectedGender == 1 ? "남자" : "여자"}  ${_controller.text}", style: TextStyle(fontSize: DeviceInfo.deviceInfo.contains("Windows") ? MediaQuery.of(context).size.width * 0.02 : MediaQuery.of(context).size.width * 0.04, color: Colors.black)),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                        _inputBox(),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    _drpoDownButton(years, "생년"),
                                    _drpoDownButton(months, "생월"),
                                    _drpoDownButton(days, "생일"),
                                    _drpoDownButton(sex, "성별")
                                ]
                            )
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        _isLoading ? CircularProgressIndicator(
                          color: Colors.black,
                        ) :
                        _submit(context, _controller.text, selectedYear!, selectedMonth!, selectedDay!, selectedGender!)
                    ]
                )
            )
        );
    }

    Widget _drpoDownButton(List<int> items, String hint) {
        bool isSex = false;
        if (hint == "성별") isSex = !isSex;

        int? selectedValue;
        if (hint == "생년") selectedValue = items.contains(selectedYear) ? selectedYear : null;
        else if (hint == "생월") selectedValue = items.contains(selectedMonth) ? selectedMonth : null;
        else if (hint == "생일") selectedValue = items.contains(selectedDay) ? selectedDay : null;
        else if (hint == "성별") selectedValue = items.contains(selectedGender) ? selectedGender : null;

        return DropdownButton<int>(
            iconSize: MediaQuery.of(context).size.width * 0.05,
            iconEnabledColor: Colors.white,
            value: selectedValue, // 선택된 값
            hint: Text(hint, style: TextStyle(color: Colors.black)), // 기본 힌트
            dropdownColor: Colors.white,
            items: isSex ? items.map((value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value == 1 ? "남자" : "여자")
                        );
                    }).toList() : items.map((value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value.toString())
                        );
                    }).toList(),
            onChanged: (value) {
                setState(() {
                        if (hint == "생년") selectedYear = value;
                        else if (hint == "생월") selectedMonth = value;
                        else if (hint == "생일") selectedDay = value;
                        else if (hint == "성별") selectedGender = value;
                    });
            }
        );
    }
    Widget _inputBox() {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                        controller: _controller, // 입력된 텍스트 저장
                        decoration: InputDecoration(
                            fillColor: Colors.black54,
                            hoverColor: Colors.black54,
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: "이름을 입력하세요",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                            )
                        )
                    )
                )
            ]
        );
    }
    Widget _submit(BuildContext context, String name, int year, int month, int day, int gender) {
      String _selectedSex = gender == 1 ? "남자" : "여자";
      UserInfoDTO userInfoDTO = UserInfoDTO(name: name, year: year, month: month, day: day, gender: _selectedSex);
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              )),
          onPressed: () async {
            log("INFO_INPUT_VIEW: 분석 요청 - 1");
            InfoInputViewModel viewModel = InfoInputViewModel();
            whenLoading();
            await viewModel.analyzeReqToRepo(userInfoDTO);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultView()));
          },
          child: Text("분석 요청")
      );
    }
}

Widget _infoText(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
        child: Center(
            child: Text("아래 입력한 정보는 분석에만 사용됩니다.\n서버 및 해당 기기에 저장되지 않습니다.",
                style: TextStyle(fontSize: DeviceInfo.deviceInfo.contains("Windows") ? MediaQuery.of(context).size.width * 0.02 : MediaQuery.of(context).size.width * 0.04, color: Colors.black54))
        )
    );

}