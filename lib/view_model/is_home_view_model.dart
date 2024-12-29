import 'dart:convert';

import 'package:battari/logger.dart';
import 'package:battari/model/dto/app_service_communication/souguu_notification_between_app_and_service_dto.dart';
import 'package:battari/model/dto/websocket/websocket_dto.dart';
import 'package:battari/service/websocket_parser.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_home_view_model.g.dart';

@Riverpod(keepAlive: true)
class IsHomeViewModel extends _$IsHomeViewModel {
  @override
  Future<bool> build() async {
    logger.i("IsHomeViewModel build");

    if (!await FlutterForegroundTask.isAppOnForeground) {
      throw Exception("this notifier is only available for foreground app");
    }

    bool? isHome;

    func(dto) async {
      if (dto.type == "is_home") {
        isHome = dto.data['is_home'];
      }
    }

    dealNotificationListener = func;

    int counter = 0;
    // 3秒まつ
    while (counter++ < 30 && isHome == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    dealNotificationListener = null;
    if (isHome != null) {
      return isHome!;
    }
    return true;
  }

  void setIsHome(bool isHome) {
    state.maybeWhen(
        orElse: () => null,
        data: (value) {
          state = AsyncData(isHome);
        });
  }
}
