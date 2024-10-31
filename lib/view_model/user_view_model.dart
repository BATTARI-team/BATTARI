import 'dart:convert';

import 'package:battari/main.dart';
import 'package:battari/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'user_view_model.g.dart';

const IpAddress = "";

@Riverpod(keepAlive: true)
class UserViewModel extends _$UserViewModel {
  @override
  FutureOr<UserState?> build() async {
    int id = 2;
    String userId = "takuto1127";
    String password = "Mia.kata.1127";
    String token = "";
    await http
        .post(Uri.parse('http://$IpAddress:5050/User/Login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'userId': userId,
              'password': password,
            }))
        .then((value) => token = jsonDecode(value.body)["token"]);
    return UserState(
      id: id,
      userId: userId,
      name: password,
      token: token,
    );
  }
}
