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
			Uri.parse('ws://192.168.11.10:5050/ws'),
		);

		return StreamBuilder(stream: channel.stream,
		builder: (context, snapshot) {
			return Column(
			  children: [
			    Text(snapshot.hasData ? '${snapshot.data}' : 'No data'),
					TextButton(child: const Text('Send message'),
					  onPressed: () {
					    channel.sink.add('Hello!');
					  },
					),
				],
			);
		});
  }


}
