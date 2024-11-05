import 'dart:convert';

import 'package:battari/main.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/state/user_state.dart';
import 'package:battari/view_model/user_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'user_view_model.g.dart';

const IpAddress = "169.254.208.85";

@Riverpod(keepAlive: true)
class UserViewModel extends _$UserViewModel {
  @override
  FutureOr<UserState?> build() async {
    var user = await ref.watch(userSharedPreferencesRepositoryProvider).get();
    return user;
  }

  void setToken(String token) {
    state.maybeWhen(
        orElse: () {},
        data: (data) {
          if (data == null) return;
          state = AsyncData(data.copyWith(token: token));
        });
  }

  void setUser(UserState user) {
    state.maybeWhen(
      orElse: () {},
      data: (data) {
        if (data == null) return;
        state = AsyncData(data.copyWith(
          id: user.id,
          userId: user.userId,
          name: user.name,
          token: user.token,
        ));
      },
    );
  }

  Future<bool> login() async {
    int id = 0;
    String token = "";
    String refreshToken = "";
    String name = "";
    var userFormState = ref.watch(userFormViewModelProvider);
    debugPrint("userFormState.BattariId: ${userFormState.BattariId}");
    try {
      await http
          .post(Uri.parse('http://$IpAddress:5050/User/Login'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'userId': userFormState.BattariId,
                'password': userFormState.Password,
              }))
          .then((value) {
        var decoded = jsonDecode(value.body);
        token = decoded["token"];
        refreshToken = decoded["refreshToken"];
      });
    } catch (e) {
      print(e);
      return false;
    }
    debugPrint("token: $token");

    try {
      await http.put(Uri.parse('http://$IpAddress:5050/User/GetUserByUserId?userId=${userFormState.BattariId}'), headers: <String, String>{
        'Authorization': 'Bearer $token',
      }).then((value) {
        var user = jsonDecode(value.body);
        name = user["name"];
        // jsonから直接int持ってこれた
        id = user["id"];

        debugPrint("name: $name, id: ${id.toString()}");
      });
    } catch (e) {
      print(e);
      return false;
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
      ref.read(userViewModelProvider.notifier).setToken(token);
      ref.read(userViewModelProvider.notifier).setUser(user);

      return true;
    }
    return false;
  }
}
