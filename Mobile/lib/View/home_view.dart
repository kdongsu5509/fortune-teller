import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/device_info.dart';
import 'info_input_view.dart';

class HomeView extends StatefulWidget {
    const HomeView({super.key});

    @override
    State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
    @override
    Widget build(BuildContext context) {
        String title1 = "ChatGPT가 분석해주는";
        String title2 = "나의 사주";

        return Scaffold(
            body: GestureDetector(
                onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoInputView()));
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    width: double.infinity, // 전체 화면 너비
                    height: double.infinity, // 전체 화면 높이
                    child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                            Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        applicationTitle(context, title1, title2)
                                    ]
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.1
                                ),
                                child: Text("  아무 곳이나\n터치 하여 시작", style: TextStyle(fontSize: DeviceInfo.deviceInfo.contains("Windows") ? MediaQuery.of(context).size.width * 0.03 : MediaQuery.of(context).size.width * 0.05, color: Colors.grey)))
                        ]
                    )
                )
            )
        );
    }
}

Widget applicationTitle(BuildContext context, String title1, String title2) {
    return Column(
        children: [
            Text(
                title1,
                style: titleStyle(context, 0.07),
                textAlign: TextAlign.center
            ),
            Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02)),
            Text(
                title2,
                style: titleStyle(context, 0.09),
                textAlign: TextAlign.center
            )
        ]
    );
}

TextStyle titleStyle(BuildContext context, double fontSize) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.width * fontSize,
        color: Colors.black,
        fontWeight: FontWeight.bold
    );
}