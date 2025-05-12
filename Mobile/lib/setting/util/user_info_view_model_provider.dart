import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/user_info_update_view_model.dart';

final userInfoUpdateViewModelProvider = ChangeNotifierProvider<UserInfoUpdateViewModel>((ref) {
  return UserInfoUpdateViewModel(ref);
});
