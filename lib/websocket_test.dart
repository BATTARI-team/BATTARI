import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketTest extends StatefulWidget{
  const WebSocketTest({super.key});

  @override
  State<WebSocketTest> createState() => _WebSocketTestState();
}

class _WebSocketTestState extends State<WebSocketTest> {
  @override
  Widget build(BuildContext context) {
		final channel = WebSocketChannel.connect(
			Uri.parse('wss://192.168.10.3:5050/ws'),
		);

		return StreamBuilder(stream: channel.stream,
		builder: (context, snapshot) {
			return Text(snapshot.hasData ? '${snapshot.data}' : 'No data');
		});
  }


}
