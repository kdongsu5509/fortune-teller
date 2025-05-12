import 'package:ai_fortune_teller_app/common/router.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
    UserInfoCard(this.sw, {super.key});
    final double sw;
    final String? name = '등록된 사용자 없음';
    final String? birthDate = DateTime.now().toString().split(' ')[0];
    final String? birthHour = DateTime.now().toString().split(' ')[1].split('.')[0].split(':')[0] + '시';
    final String? birthMinute = DateTime.now().toString().split(' ')[1].split('.')[0].split(':')[1] + '분';

    @override
    Widget build(BuildContext context) {
        final sh = MediaQuery.of(context).size.height;

        return Card(
            elevation: 2,
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sw * 0.04)),
            child: Padding(
                padding: EdgeInsets.all(sw * 0.04),
                child: Row(
                    children: [
                        SizedBox(width: sw * 0.04),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        name!,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontSize: sw * 0.045,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    SizedBox(height: sh * 0.005),
                                    Text(
                                        '${birthDate!} ${birthHour!} ${birthMinute!}',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: sw * 0.035)
                                    ),
                                    SizedBox(height: sh * 0.005)
                                ]
                            )
                        ),
                        GestureDetector(onTap: () {
                          router.push('/settings/user');
                        }, child: Icon(Icons.edit, size: sw * 0.06, color: Theme.of(context).colorScheme.primary))
                    ]
                )
            )
        );
    }
}