import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Dto/user_info_dto.dart';
import 'my_dio.dart';

/**
 * @Structure :
 * 관상 분석은 서버에서 진행됩니다. 그리고 그 결과는 임시적으로만 저장하면 되고, 따로 저장할 필요는 없습니다.
 * 따라서 해당 클래스는 레포지토리를 거치지 않고, ViewModel과 Server를 직접 연결합니다.
 */

///
class AnalyzeService {

    Dio dio = MyDio().get();


    Future<String> reqAnalyzeToServer(UserInfoDTO info) async {
      try {
        final response = await dio.post(
            "${dotenv.env['baseUrl']}/analyze",
            data: info.toJson(),
        );

        if (response.statusCode == 200) {
          return response.data!;
        } else {
          throw Exception('서버 에러: ${response.statusCode}');
        }
      } catch (e) {
        log("[에러] reason : ${e.toString()}");
        return Future.error(e);  // 스트림 소비자에 에러를 전달
      }
    }
}

