import 'package:ai_fortune_teller_app/common/router.dart';
import 'package:ai_fortune_teller_app/setting/repository/model/user_info_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../setting/repository/model/birth_time.dart';
import '../../setting/util/user_info_provider.dart';

class UserInfoCard extends ConsumerStatefulWidget {
    UserInfoCard(this.sw, {super.key});
    final double sw;

  @override
  ConsumerState<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends ConsumerState<UserInfoCard> {

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        final userInfo = ref.watch(userInfoProvider);
        final sh = MediaQuery.of(context).size.height;

        return Card(
            elevation: 2,
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.sw * 0.04)),
            child: Padding(
                padding: EdgeInsets.all(widget.sw * 0.04),
                child: Row(
                    children: [
                        SizedBox(width: widget.sw * 0.04),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        userInfo?.name ?? '등록된 사용자 없음',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontSize: widget.sw * 0.045,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    SizedBox(height: sh * 0.005),
                                    Text(
                                        '${userInfo?.birthDate.toString().split(' ')[0] ?? DateTime.now().toString().split(' ')[0]}  ${userInfo?.birthTime.label ?? BirthTime.Missing.label}',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: widget.sw * 0.035)
                                    ),
                                    SizedBox(height: sh * 0.005)
                                ]
                            )
                        ),
                        GestureDetector(onTap: () {
                          router.push('/settings/user');
                        }, child: Icon(Icons.edit, size: widget.sw * 0.06, color: Theme.of(context).colorScheme.primary))
                    ]
                )
            )
        );
    }
}