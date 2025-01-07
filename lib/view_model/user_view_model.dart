import 'dart:convert';
import 'dart:developer';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/model/state/user_state.dart';
import 'package:battari/util/token_util.dart';
import 'package:battari/view_model/user_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

part 'user_view_model.g.dart';

const endPoint = "http://takutk.com:6060";

@Riverpod(keepAlive: true)
class UserViewModel extends _$UserViewModel {
  @override
  UserState? build() {
    log("UserViewModel build");
    ref.onDispose(() {
      log("UserViewModel dispose");
    });
    return null;
  }

  Future<void> init() async {
    var user = await ref.read(userSharedPreferencesRepositoryProvider).get();
    state = user;
  }

  void setToken(String token) {
    logger.i("tokenが更新されました: $token");
    Token = token;
    if (state == null) {
      state = UserState(token: token);
      Sentry.captureMessage("state is null", hint: Hint.withMap({"message": "set token"}), level: SentryLevel.debug);
    } else {
      state = state!.copyWith(token: token);
    }
    ref.read(userSharedPreferencesRepositoryProvider).saveToken(token);
  }

  void setUser(UserState user) {
    if (state == null) {
      state = user;
    } else {
      state = state!.copyWith(
        id: user.id,
        userId: user.userId,
        name: user.name,
        token: user.token,
      );
      logger.i("userが更新されました: ${user.name}");
    }
  }

  Future<void> setHome(double latitude, double longitude) async {
    var user = state;
    if (user == null) {
      return;
    }
    ref.read(userSharedPreferencesRepositoryProvider).saveHome(latitude, longitude);
    state = user.copyWith(houseLatitude: latitude, houseLongitude: longitude);
  }

  Future<bool> refreshUser(int userIndex) async {
    try {
      var token = TokenUtil.getToken();
      String name = "";
      int id = 0;
      String userId = "";
      await http.put(Uri.parse('http://$endPoint/User/GetUser?userIndex=$userIndex'), headers: <String, String>{
        'Authorization': 'Bearer $token',
      }).then((value) {
        var user = jsonDecode(value.body);
        name = user["name"];
        id = user["id"];
        userId = user["userId"];
      });
      var user = UserState(token: token, refreshToken: TokenUtil.getRefreshToken(), name: name, id: id, userId: userId);
      setUser(user);
      ref.read(userSharedPreferencesRepositoryProvider).save(user);
      return true;
    } catch (e) {
      await Sentry.captureException(e, stackTrace: StackTrace.current, hint: Hint.withMap({"message": "refresh user failed"}));
      debugPrint(e.toString());
      return false;
    }
  }

  /// return "" if login success
  /// return error message if login failed
  Future<String> login() async {
    int id = 0;
    String token = "";
    String refreshToken = "";
    String name = "";
    var userFormState = ref.watch(userFormViewModelProvider);
    debugPrint("userFormState.BattariId: ${userFormState.BattariId}");
    debugPrint("userFormState.Password: ${userFormState.Password}");
    try {
      await http
          .post(Uri.parse('http://$endPoint/User/Login'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'userId': userFormState.BattariId,
                'password': userFormState.Password,
              }))
          .then((value) {
        debugPrint("1");
        var decoded = jsonDecode(value.body);
        debugPrint("2");
        token = decoded["token"];
        debugPrint("3");
        refreshToken = decoded["refreshToken"];
      });
    } catch (e) {
      await Sentry.captureException(e, stackTrace: StackTrace.current, hint: Hint.withMap({"message": "login failed"}));
      return e.toString();
    }
    debugPrint("token: $token");

    try {
      await http.put(Uri.parse('http://$endPoint/User/GetUserByUserId?userId=${userFormState.BattariId}'), headers: <String, String>{
        'Authorization': 'Bearer $token',
      }).then((value) {
        var user = jsonDecode(value.body);
        name = user["name"];
        // jsonから直接int持ってこれた
        id = user["id"];

        debugPrint("name: $name, id: ${id.toString()}");
        Sentry.configureScope((p0) {
          if (p0.user != null) {
            p0.user!.copyWith(id: id.toString(), username: userFormState.BattariId);
          }
        });
      });
    } catch (e) {
      await Sentry.captureException(e, stackTrace: StackTrace.current, hint: Hint.withMap({"message": "get user by user id failed"}));
      return e.toString();
    }

    if (token.isNotEmpty) {
      // 全部いけた時
      var user = UserState(
        id: id,
        userId: userFormState.BattariId,
        name: name,
        refreshToken: refreshToken,
        token: token,
      );
      await ref.read(userSharedPreferencesRepositoryProvider).save(user);
      setToken(token);
      setUser(user);

      debugPrint("login success");
      await Sentry.captureMessage("$id logged in");

      return "";
    }
    return "ログインに失敗しました．";
  }

  Future<String> refreshToken([int? userIndexArg, String? refreshTokenArg]) async {
    String token = "";
    int userIndex = userIndexArg ??
        () {
          if (state == null) return 0;
          return state!.id;
        }();
    String refreshToken = refreshTokenArg ??
        () {
          if (state == null) return "";
          return state!.refreshToken;
        }();

    try {
      debugPrint('http://$endPoint/User/RefreshToken');
      await http
          .post(Uri.parse('http://$endPoint/User/RefreshToken'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, Object>{
                'refreshToken': refreshToken,
                'userIndex': userIndex,
              }))
          .then((value) {
        if (value.statusCode == 200) {
          token = value.body;
          Token = value.body;
          ref.read(userViewModelProvider.notifier).setToken(token);
        }
      });
    } catch (e) {
      Sentry.captureException(e, stackTrace: StackTrace.current, hint: Hint.withMap({"message": "refresh token failed"}));
      return e.toString();
    }
    if (token.isNotEmpty) {
      // 全部いけた時
      await ref.read(userSharedPreferencesRepositoryProvider).saveToken(token);
      ref.read(userViewModelProvider.notifier).setToken(token);
      await Sentry.captureMessage("$userIndex refreshed token");

      logger.d("init done");
      return token;
    }
    return "";
  }

  Future<void> loginWithUserState(UserState user) async {
    await ref.read(userSharedPreferencesRepositoryProvider).save(user);
    ref.read(userViewModelProvider.notifier).setToken(user.token);
    ref.read(userViewModelProvider.notifier).setUser(user);
  }
}
