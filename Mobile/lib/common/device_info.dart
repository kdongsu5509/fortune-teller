import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static late String _deviceInfo; // 저장할 변수 추가

  static Future<void> initDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceData = await deviceInfoPlugin.deviceInfo;
    _deviceInfo = deviceData.toString(); // 정보 저장
  }

  static String get deviceInfo => _deviceInfo; // Getter 사용
}
