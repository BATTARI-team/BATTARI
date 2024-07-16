import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通知'),
      ),
      body: ListView.builder(itemBuilder: (context, int index) {
        if (index.isOdd) return Divider();
        return ListTile(title: Text('通知 $index'));
      }),
    );
  }
}
