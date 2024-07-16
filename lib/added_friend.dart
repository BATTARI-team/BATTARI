import 'package:flutter/material.dart';

class AddedFriendView extends StatelessWidget {
  const AddedFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('友達追加'),
      ),
      body: ListView.builder(itemBuilder: (context, int index) {
        if (index.isOdd) return Divider();
        return ListTile(title: Text('友達 $index'));
      }),
    );
  }
}
