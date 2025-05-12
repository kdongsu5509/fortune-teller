import 'dart:developer';

import '../setting/repository/model/user_info_dto.dart';
import '../DataLayer/Repository/analyze_repository_local.dart';

class InfoInputViewModel {
  Future<void> analyzeReqToRepo(UserInfoDTO info) async {
    log("INFO_INPUT_VIEW_MODEL: 분석 요청 - 2");
    await AnalyzeRepositoryLocal().doAnalyze(info);
  }
}