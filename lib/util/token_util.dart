import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenUtil {
  static String getToken() {
    var token = ProviderContainer().read(userViewModelProvider)?.token;
    return token ?? "";
  }

  static String getRefreshToken() {
    var token = ProviderContainer().read(userViewModelProvider)?.refreshToken;
    return token ?? "";
  }
}
