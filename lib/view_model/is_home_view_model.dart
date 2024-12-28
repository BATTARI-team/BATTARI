import 'package:battari/service/websocket_parser.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_home_view_model.g.dart';

@riverpod
class IsHomeViewModel extends _$IsHomeViewModel {
  @override
  Future<bool> build() async {
    if (!await FlutterForegroundTask.isAppOnForeground) {
      throw Exception("this notifier is only available for foreground app");
    }
    bool? isHome = false;

    func(dto) async {
      if (dto.type == "is_home") {
        isHome = dto.data['is_home'];
      }
    }

    dealNotificationListeneres.add(func);
    int counter = 0;
    // 3秒まつ
    while (counter++ < 30 && isHome == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    dealNotificationListeneres.remove(func);
    if (isHome != null) {
      return isHome!;
    }
    return false;
  }
}
