// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_form_state.freezed.dart';

@freezed
class UserFormState with _$UserFormState {
  const factory UserFormState({
    @Default("") BattariId,
    @Default("") Password,
  }) = _UserFormState;
}
