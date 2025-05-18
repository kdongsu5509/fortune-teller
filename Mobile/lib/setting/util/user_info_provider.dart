import 'dart:convert';
import 'package:ai_fortune_teller_app/setting/repository/model/user_info_dto.dart';
import 'package:ai_fortune_teller_app/util/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_provider.g.dart';

@Riverpod(keepAlive: true) // 앱 전역에서 사용하므로 keepAlive 추천
class UserInfo extends _$UserInfo {
  @override
  UserInfoDTO? build() => null; // 초기 상태는 null

  Future<void> load() async {
    final storage = await ref.read(secureStorageProvider.future);
    final json = await storage.get('userInfo');
    if (json != null) {
      state = UserInfoDTO.fromJson(jsonDecode(json));
    }
  }

  Future<void> save(UserInfoDTO dto) async {
    state = dto;
    final storage = await ref.read(secureStorageProvider.future);
    await storage.set('userInfo', jsonEncode(dto.toJson()));
  }

  Future<void> delete() async {
    state = null;
    final storage = await ref.read(secureStorageProvider.future);
    await storage.remove('userInfo');
  }

  Future<void> updateUserInfo(UserInfoDTO userInfoDTO) async {
    await delete();
    await save(userInfoDTO);
  }
}
