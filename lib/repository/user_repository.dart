import 'package:battari/model/state/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_repository.g.dart';

@riverpod
Raw<Future<SharedPreferences>> sharedPreferences(ref) async {
  return await SharedPreferences.getInstance();
}

abstract class IUserRepository {
  Future<UserState?> get();
  Future<void> save(UserState userState);
  Future<void> saveToken(String token);
  Future<void> clear();
}

@riverpod
UserSharedPreferencesRepository userSharedPreferencesRepository(ref) {
  return UserSharedPreferencesRepository(ref);
}

class UserSharedPreferencesRepository extends IUserRepository {
  Ref ref;
  UserSharedPreferencesRepository(this.ref);
  @override
  Future<UserState?> get() async {
    var reference = await ref.read(sharedPreferencesProvider);
    String? refreshToken = reference.getString("refresh_token");
    String? userId = reference.getString("user_id");
    int? id = reference.getInt("id");
    String? name = reference.getString("name");

    if (refreshToken == null || userId == null || id == null || name == null) {
      return null;
    }
    return UserState(
      refreshToken: refreshToken,
      userId: userId,
      id: id,
      name: name,
    );
  }

  @override
  Future<void> save(UserState userState) async {
    var reference = await ref.read(sharedPreferencesProvider);
    await reference.setString("refresh_token", userState.refreshToken);
    await reference.setString("user_id", userState.userId);
    await reference.setInt("id", userState.id);
    await reference.setString("name", userState.name);
  }

  Future<void> saveToken(String token) async {
    var reference = await ref.read(sharedPreferencesProvider);
    await reference.setString("token", token);
  }

  @override
  Future<void> clear() async {
    var reference = await ref.read(sharedPreferencesProvider);
    await reference.clear();
  }
}
