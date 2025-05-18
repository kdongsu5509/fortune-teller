import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    const String _privacyPolicyContent = '''
1. 수집하는 개인정보 항목 및 수집 방법
본 앱은 사용자에게 맞춤형 운세 분석 및 AI 기반 서비스를 제공하기 위해 다음과 같은 개인정보를 수집할 수 있습니다.

[필수 수집 항목]
- 이름, 생년월일, 성별: 사주 및 운세 분석 등 기본 서비스 제공 목적

[선택 수집 항목]
- 출생 시간: 분석 정확도 향상 목적
- 꿈 해몽 요청 내용, 오늘의 운세 질문, 관상 사진: AI 분석 및 결과 제공 목적

※ 수집 방법: 사용자가 앱 내에서 직접 입력하거나 파일 업로드를 통해 수집됩니다.

2. 개인정보의 수집 및 이용 목적
수집된 개인정보는 다음 목적을 위해 사용됩니다.
- 운세/사주/관상 등의 AI 분석 결과 제공
- 서비스 이용 기록 기반의 맞춤 서비스 제공
- AI 품질 향상 및 통계 분석
- 민원 처리 및 고객지원 응대

3. 개인정보의 보유 및 이용 기간
- 사용자의 입력 정보는 기기 내에 로컬 저장되며, 서버에는 저장되지 않습니다.
- 단, AI 학습 품질 향상과 로그 분석을 위한 요청 데이터(사주 정보, 해몽 텍스트, 관상 사진 등)는 최대 30일 동안 암호화된 상태로 보관된 후 자동 파기됩니다.
- 사용자가 직접 앱을 삭제하거나, 앱 내에서 정보 삭제 요청 시 즉시 파기됩니다.

4. 제3자 제공 및 위탁
- 본 앱은 이용자의 개인정보를 외부에 제공하지 않으며, 어떠한 외부 업체에도 처리 위탁하지 않습니다.
- 단, 법령에 의한 요청이 있는 경우에는 예외로 할 수 있습니다.

5. 이용자의 권리 및 행사 방법
- 이용자는 언제든지 앱 내 설정 메뉴를 통해 입력한 개인정보를 확인하거나 수정, 삭제할 수 있습니다.
- 로컬 저장 데이터는 앱 삭제 시 자동으로 파기됩니다.
- 정보 열람, 정정, 삭제 요청은 설정 메뉴 또는 이메일을 통해 접수하실 수 있습니다.

6. 만 14세 미만 아동의 개인정보
- 본 앱은 만 14세 미만 아동의 개인정보를 의도적으로 수집하지 않으며, 관련 정보가 확인될 경우 즉시 삭제됩니다.

7. 개인정보 보호 책임자 및 문의
- 책임자: 고동수
- 이메일: kod66170@google.com
- 개인정보 보호 관련 문의사항은 위 이메일을 통해 언제든지 접수하실 수 있으며, 신속히 답변드리겠습니다.

8. 고지 및 정책 변경
- 본 개인정보 처리방침은 2025년 5월 16일부터 적용됩니다.
- 내용 변경 시 앱 내 알림 또는 공지사항을 통해 사전 고지합니다.
''';

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(sw * 0.06),
        child: ListView(
          children: [
            Text(
              "개인정보 처리방침",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontSize: sw * 0.06),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: sw * 0.05),
            Text(
              _privacyPolicyContent,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: sw * 0.04),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
