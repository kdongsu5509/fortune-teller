import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

import '../DataLayer/Repository/analyze_repository_local.dart';

/**
 * @Structure :
 * 관상 분석은 서버에서 진행됩니다. 그리고 그 결과는 임시적으로만 저장하면 되고, 따로 저장할 필요는 없습니다.
 * 따라서 해당 클래스는 레포지토리를 거치지 않고, Service를 직접 호출합니다.
 */

///

class ResultViewModel extends ChangeNotifier {
  final AnalyzeRepositoryLocal _analyzeRepositoryLocal = AnalyzeRepositoryLocal();
  final StreamController<String> _streamController = StreamController<String>.broadcast();

  Stream<String> get resultStream => _streamController.stream;

  ResultViewModel();

  Future<void> loadFaceData() async {
    try {
      String? result = AnalyzeRepositoryLocal.analyzeResult;
      log("[VM] 분석 결과: $result");
      for (int i = 0; i < result!.length; i++) {
        _streamController.add(result[i]);
        await Future.delayed(Duration(milliseconds: 100));
      }
      _streamController.close();
    } catch (e) {
      _streamController.addError(e);
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}