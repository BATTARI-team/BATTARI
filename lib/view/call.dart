import 'package:battari/service/souguu_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Call extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    var souguuInfo = ref.watch(souguuServiceInfoProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("遭遇相手：${souguuInfo.souguu}"),
          const Text('Call'),
        ],
      ),
    );
  }
}
