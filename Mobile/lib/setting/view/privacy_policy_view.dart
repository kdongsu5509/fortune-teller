import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(sw * 0.06),
        child: ListView(
          children: [
            Text(
              "개인정보 처리방침",
              style: TextStyle(fontSize: sw*0.075, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              "1. 수집하는 개인정보 항목",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("앱은 이름, 생년월일, 성별, (선택) 출생시간 등 사주 분석을 위한 최소한의 정보를 수집합니다. 또한 사용자가 입력하는 꿈 해몽, 오늘의 운세 요청 내용 및 관상 사진 등도 수집될 수 있습니다."),
            const SizedBox(height: 16),
            const Text(
              "2. 개인정보 이용 목적",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("수집된 정보는 사용자 맞춤 운세 분석 및 결과 제공, AI 품질 개선, 서비스 이용 기록 확인 등을 위해 사용됩니다."),
            const SizedBox(height: 16),
            const Text(
              "3. 개인정보의 보관 및 파기",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("입력된 정보는 기기 내에 로컬 저장될 수 있으며, 서버에 직접 저장되지는 않습니다. 단, AI 분석을 위한 로그에는 사용자 요청 데이터(예: 사주 정보, 해몽 텍스트, 관상 사진 등)가 일시적으로 저장될 수 있습니다."),
            const SizedBox(height: 16),
            const Text(
              "4. 이용자의 권리",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("언제든지 앱 내 설정에서 정보를 수정하거나 삭제할 수 있으며, 로컬 저장 데이터는 사용자의 조작 또는 앱 삭제 시 제거됩니다."),
            const SizedBox(height: 16),
            const Text(
              "5. 책임자의 연락처",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("개인정보 관련 문의사항은 kod66170@google.com 으로 연락주세요."),
          ],
        ),
      ),
    );
  }
}
