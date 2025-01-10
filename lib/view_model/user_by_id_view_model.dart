import 'dart:convert';

import 'package:battari/main.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'user_by_id_view_model.g.dart';

@riverpod
Raw<Future<String>> userProviderById(ref, int id) async {
  var result = await http.put(Uri.parse('http://$ipAddress:$port/User/GetUser?userIndex=$id'), headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $Token',
  });
  return result.body;
}

@riverpod
Raw<Future<String>> userNameProviderById(Ref ref, int id) async {
  if (id == 3) return "ルリ";
  if (id == 1) return "タクト";
  return jsonDecode(await ref.watch(userProviderByIdProvider(id)))['name'];
}

@riverpod
Raw<Future<String>> userIdProviderById(ref, int id) async {
  if (id == 3) return "fks_r725";
  if (id == 1) return "takuto1127";
  return jsonDecode(await ref.watch(userProviderByIdProvider(id)))['userId'];
}
