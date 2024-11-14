import 'dart:developer';

import 'package:battari/model/state/user_form_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_form_view_model.g.dart';

@riverpod
class UserFormViewModel extends _$UserFormViewModel {
  @override
  UserFormState build() {
    log("UserFormViewModel build");
    return const UserFormState();
  }

  void changeBattariId(String battariId) {
    state = state.copyWith(BattariId: battariId);
  }

  void changePassword(String password) {
    state = state.copyWith(Password: password);
  }
}
