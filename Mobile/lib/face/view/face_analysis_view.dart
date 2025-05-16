import 'package:ai_fortune_teller_app/common/ask_to_gpt_button.dart';
import 'package:flutter/material.dart';

import '../../common/content_card.dart';

class FaceAnalysisView extends StatelessWidget {
    const FaceAnalysisView({super.key});

    @override
    Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
        final sw = size.width;
        final sh = size.height;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        final face = {
            "summary": "당신은 전체적으로 강한 인상을 주는 이목구비를 지녔으며, 리더십과 책임감이 돋보이는 인상입니다.",
            "keywords": ["통찰력", "리더십", "긍정 에너지"],
            "features": {
                "eyes": {
                    "title": "👁 눈",
                    "description": "눈매가 또렷하고 길게 뻗어 있어, 판단력과 통찰력이 뛰어난 사람입니다."
                },
                "nose": {
                    "title": "👃 코",
                    "description": "높은 콧대는 자존심이 강하고 독립적인 성향을 나타냅니다."
                },
                "mouth": {
                    "title": "👄 입",
                    "description": "입꼬리가 올라가 있어 긍정적인 에너지와 말솜씨를 지닌 타입입니다."
                },
                "forehead": {
                    "title": "🧠 이마",
                    "description": "넓은 이마는 지적 능력과 미래 지향적인 사고를 의미합니다."
                }
            },
            "advice": "자신의 의견을 더욱 명확하게 표현하고, 주변 사람들과의 조화를 의식하면 더욱 큰 신뢰를 얻을 수 있습니다."
        };

        final features = face['features'] as Map<String, dynamic>? ?? {};
        final faceSummary = face['summary'] as String? ?? '';
        final faceAdvice = face['advice'] as String? ?? '';

        return Scaffold(
            body: Padding(
                padding: EdgeInsets.all(sw * 0.06),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            /// 요약 설명
                            Text(
                                "🔍 총평",
                                style: Theme.of(
                                    context
                                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                            ),
                            SizedBox(height: sh * 0.01),
                            Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(sw * 0.04),
                                    child: Text(
                                        faceSummary,
                                        style: Theme.of(context).textTheme.bodyMedium
                                    )
                                )
                            ),
                            SizedBox(height: sh * 0.025),
                            Text(
                                "🌟 특징 키워드",
                                style: Theme.of(
                                    context
                                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                            ),
                            SizedBox(height: sw * 0.015),
                            Wrap(
                                spacing: 8,
                                children: List<Widget>.from(
                                    (face['keywords'] as List<dynamic>).map(
                                        (word) => Chip(
                                            label: Text(word),
                                            backgroundColor:
                                            isDark ? Colors.indigo[700] : Colors.indigo[50],
                                            labelStyle: TextStyle(
                                                color: isDark ? Colors.white : Colors.indigo[800]
                                            )
                                        )
                                    )
                                )
                            ),

                            SizedBox(height: sh * 0.035),

                            /// 부위별 분석
                            Text(
                                "📌 부위별 관상 분석",
                                style: Theme.of(
                                    context
                                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                            ),
                            SizedBox(height: sh * 0.015),
                            for (final key in features.keys)
                                contentsCard(
                                    context,
                                    features[key]['title'] ?? '',
                                    features[key]['description'] ?? '',
                                    sw
                                ),
                            SizedBox(height: sh * 0.035),
                            contentsCard(context, "💡 조언", faceAdvice, sw),
                            getAskToGptButton(isDark, sw),
                            SizedBox(height: sh * 0.02),
                            Center(
                                child: Text(
                                    "※ 본 분석은 AI 기반 관상 인식 결과이며 참고용입니다.",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: isDark ? Colors.white70 : Colors.black54
                                    ),
                                    textAlign: TextAlign.center
                                )
                            ),
                            SizedBox(height: sh * 0.02)
                        ]
                    )
                )
            )
        );
    }
}
