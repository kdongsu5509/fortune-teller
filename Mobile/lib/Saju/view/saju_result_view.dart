import 'package:flutter/material.dart';

class SaJuResultView extends StatelessWidget {
  final Map<String, dynamic> data;
  const SaJuResultView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final userName = data['user']?['name'] ?? '사용자';
    final analysis = data['result'] ?? '분석 결과가 없습니다.';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$userName님의 사주 결과', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(analysis, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> handleNextPage(BuildContext context) async {
  final adLoaded = await loadInterstitialAd();
  final userFuture = fetchUserData();
  final resultFuture = fetchSajuAnalysis();

  if (adLoaded) {
    showAd(onAdComplete: () async {
      final results = await Future.wait([userFuture, resultFuture]);
      final data = {
        'user': results[0],
        'result': results[1],
      };
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SaJuResultView(data: data)),
      );
    });
  } else {
    final results = await Future.wait([userFuture, resultFuture]);
    final data = {
      'user': results[0],
      'result': results[1],
    };
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SaJuResultView(data: data)),
    );
  }
}

// Mock implementations:
Future<bool> loadInterstitialAd() async {
  // TODO: Replace with actual Ad SDK integration
  await Future.delayed(const Duration(seconds: 1));
  return true;
}

void showAd({required VoidCallback onAdComplete}) async {
  // TODO: Replace with actual ad display logic
  await Future.delayed(const Duration(seconds: 3));
  onAdComplete();
}

Future<Map<String, dynamic>> fetchUserData() async {
  await Future.delayed(const Duration(seconds: 1));
  return {'name': '홍길동'};
}

Future<String> fetchSajuAnalysis() async {
  await Future.delayed(const Duration(seconds: 2));
  return '당신은 재물이 따르고 주변 사람들과 조화를 이루는 성향입니다.';
}