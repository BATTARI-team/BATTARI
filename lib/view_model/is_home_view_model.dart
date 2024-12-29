import 'dart:convert';

import 'package:battari/logger.dart';
import 'package:battari/model/dto/app_service_communication/souguu_notification_between_app_and_service_dto.dart';
import 'package:battari/model/dto/websocket/websocket_dto.dart';
import 'package:battari/service/websocket_parser.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_home_view_model.g.dart';

@riverpod
class IsHomeViewModel extends _$IsHomeViewModel {
  @override
  Future<bool> build() async {
    logger.i("IsHomeViewModel build");

    if (!await FlutterForegroundTask.isAppOnForeground) {
      throw Exception("this notifier is only available for foreground app");
    }

    bool? isHome = false;

    func(dto) async {
      logger.i("きた3");
      if (dto.type == "is_home") {
        logger.i("きた4");
        isHome = dto.data['is_home'];
      }
    }

    dealNotificationListeneres.add(func);
    int counter = 0;
    // 3秒まつ
    while (counter++ < 300 && isHome == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    dealNotificationListeneres.remove(func);
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
