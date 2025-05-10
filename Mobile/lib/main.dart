import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'View/home_view.dart';
import 'common/device_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "appdong.env"); // ✅ 환경 변수 로드
  await DeviceInfo.initDeviceInfo();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "ChosunCentennial"),
      debugShowCheckedModeBanner: false,
      title: 'APPDONGU SAJU',
      home: const HomeView(),
    );
  }
}
