import 'dart:developer';

import '../Dto/user_info_dto.dart';
import '../Service/AnalyzeService.dart';

class AnalyzeRepositoryLocal {
  static String? analyzeResult;

  Future<void> doAnalyze(UserInfoDTO info) async {
    log("ANALYZEREPO: DOANALYZE - 3");
    analyzeResult = await AnalyzeService().reqAnalyzeToServer(info);
    log("[REPO] 분석 결과 획득 완료 - 4");
  }
}
