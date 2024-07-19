import 'package:battari/battari_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final ProviderRef ref;
  WebSocketService(this.ref);
  static WebSocketChannel WebSocketChannelHandler =
      WebSocketChannel.connect(Uri.parse('ws://$serverAddress/souguu'));
}

final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  return WebSocketService(ref);
});
