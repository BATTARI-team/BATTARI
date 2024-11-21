import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default("") String token,
    @Default("") String refreshToken,
    @Default("") String userId,
    @Default(0) int id,
    @Default("") String name,
  }) = _UserState;
}
