import 'dart:convert';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/model/dto/websocket/cancel_call_websocket_dto.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;

class CallUtil {
  static Future<void> cancelCall([String reason = ""]) async {
    var response = await http.put(Uri.parse('http://$endPoint/SouguuInfo/CancelCall'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $Token',
        },
        body: jsonEncode(CancelCallWebsocketDto(reason: reason).toJson()));
    logger.d(response.body + response.statusCode.toString());
    return;
  }
}
